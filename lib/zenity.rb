module Zenity
  class << self

    def calendar(options=false)
      cmd = 'zenity --calendar'
      if options == false
        %x[ #{cmd} ]
      else
        %x[ #{parseopts(cmd, options)} ]
      end
    end

    private
    def parseopts(cmd, options)
      options.each do |k, v|
        cmd << " --#{k}='#{v}'"
      end
      cmd
    end
  end
end

