module Zenity
  class << self

    # Let's just use method_missing instead of defining all of those.
    def method_missing(m, options=false)
      if [
        :calendar,
        :entry,
        :error,
        :'file-selection',
        :info,
        :list,
        :notification,
        :progress,
        :question,
        :'text-info',
        :warning,
        :scale
      ].include? m
      ret = %x[ #{parseopts('zenity --' + m.to_s, options)} ]
    else
      raise "Unknown dialog #{m}"
    end
    if ret.rstrip == 'This option is not available. Please see --help for all possible usages.'
      raise "Invalid option"
    else
      return ret
    end
  end


  private
  def parseopts(cmd, options)
    if options != false
      options.each do |k, v|
        cmd << " --#{k}='#{v}'" if k != :arg
      end
      options[:arg].each { |opt| cmd << " --#{opt}" } if options.has_key?(:arg)
    end
    cmd
  end

end
end

