require 'sinatra'
require 'markaby'
require 'zip/zip'

Markaby::Builder.set(:indent, 2)

Sinatra::Application.set(:run => false, :environment => 
:production)

class TSSApp < Sinatra::Application
  configure do
    set :public, COMMAND_LINE.logdir
    set :logdir, COMMAND_LINE.logdir
    set :tsung_stats, COMMAND_LINE.tsung_stats
  end
  
  ##
  # Shows the list of all logs present on the machine.
  #
  # @output_types [text/html]
  # @output_languages [en-US]
  #
  get '/' do
    logdirs = (Dir.entries(options.logdir) - [".", ".."]).sort
    logdirs.reject! {|file| file =~ /\.zip/ }
    list_dirs(logdirs)  
  end
  
  ##
  # Shows a report. If the report is not generated already, it will be.
  #
  # @url_param dir The date on which the measurement was taken.
  # @get force If present and set to any value, 
  #              regeneration of the report is forced
  # @output_types [text/html]
  # @output_languages [en-US]
  #
  get '/:dir/report.html' do
    run_stats(params[:dir])
  end
  
  #
  # Delivers a report as zip file. If not generated, report generation takes place.
  #
  # @url_param [dir] The date on which the measurement was taken.
  #
  # @output_types [application/zip]
  #
  get '/:dir.zip' do
    filename = params[:dir].gsub(/:/, '-')
    unless File.exists?(File.join(options.logdir, "#{filename}.zip"))
      zip(params[:dir], filename)
    end
    attachment("#{filename}.zip")
    content_type("application/zip")
    File.read(File.join(options.logdir, "#{filename}.zip"))
  end
  
  #
  # Runs the report generation. If a report already exists, 
  # it wont be generated a second time, unless forced explicitly.
  #
  # @param dir [String] The logfile directory of the report.
  # @param force [true, false] If set to true, the report gets
  #                            created unconditionally.
  #
  # @return [String] The contents of #{dir}/report.html
  def run_stats(dir, force = false)
    Dir.chdir( File.join(options.logdir, dir) ) do
      unless File.exists?('report.html') && force == false
        system(options.tsung_stats)
      end
      File.read('report.html')
    end
  end
  
  #
  # Creates a zip file out of a directory. 
  #
  # @param dir [String] The directories name.
  # @param filename [String] The output filename.
  #
  # @return [undefined] unspecified
  def zip(dir, filename)
    Dir.chdir( File.join(options.logdir) ) do
      unless File.exists?("#{dir}.zip")
        Zip::ZipFile.open("#{filename}.zip", true) do |zf|
          Dir["#{dir}/**/*"].each { |f| zf.add(f, f) }
        end
      end
    end
  end
  
  #
  # Generates a HTML document listing of all logs present on the machine.
  #
  # @param logdirs [Array<String>] The directories that contain logs.
  #
  # @return [String<text/html>] The generated document.
  def list_dirs(logdirs)
    doc = Markaby::Builder.new
    doc.html do
      head do
        title "Logpickin'"
      end
      body do
        h1 "Pick a log:"
        ul.logs do
          logdirs.each do |dir|
            li.log do
              a "Log #{dir}", :href => "/#{dir}/report.html"
              a "As zip", :href => "/#{dir}.zip"
            end
          end
        end
      end
    end
  end
end