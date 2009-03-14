
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

  get '/' do
    logdirs = (Dir.entries(options.logdir) - [".", ".."]).sort
    logdirs.reject! {|file| file =~ /\.zip/ }
    list_dirs(logdirs)  
  end

  get '/:dir/report.html' do
    run_stats(params[:dir])
  end

  get '/:dir.zip' do
    filename = params[:dir].gsub(/:/, '-')
    unless File.exists?(File.join(options.logdir, "#{filename}.zip"))
      zip(params[:dir], filename)
    end
    attachment("#{filename}.zip")
    content_type("application/zip")
    File.read(File.join(options.logdir, "#{filename}.zip"))
  end

  def run_stats(dir)
    Dir.chdir( File.join(options.logdir, dir) ) do
      unless File.exists?('report.html')
        system(options.tsung_stats)
      end
      File.read('report.html')
    end
  end

  def zip(dir, filename)
    Dir.chdir( File.join(options.logdir) ) do
      unless File.exists?("#{dir}.zip")
        Zip::ZipFile.open("#{filename}.zip", true) do |zf|
          Dir["#{dir}/**/*"].each { |f| zf.add(f, f) }
        end
      end
    end
  end

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