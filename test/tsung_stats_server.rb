#describe TsungStatsServer do
#  it 'has inochi' do
#    assert TsungStatsServer.const_defined? :INOCHI
#
#    TsungStatsServer::INOCHI.each do |param, value|
#      const = param.to_s.upcase
#
#      assert TsungStatsServer.const_defined? const
#      TsungStatsServer.const_get(const).must_equal value
#    end
#  end
#end
#