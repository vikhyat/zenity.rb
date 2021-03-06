module Zenity
  class << self

    # Let's just use method_missing instead of defining all of those.
    def method_missing(m, options=false)
      # Check if the dialog box we have to show is allowed
      if [ :calendar, :entry, :error, :'file-selection', :info, :list,
           :notification, :progress, :question, :'text-info', :warning, :scale
      ].include? m
        # It's in the array and everything seems to be fine
        ret = %x[ #{parseopts('zenity --' + m.to_s, options)} ]
      else
        # We don't know about this dialog, raise an error
        raise "Unknown dialog #{m}"
      end
      # Check if any of the options passed were invalid.
      if ret.rstrip == 'This option is not available. Please see --help for all possible usages.'
        # Write a message to STDERR if there were invalid options, but don't
        # raise an error.
        STDERR << "Invalid option"
      else
        # Everything looks fine. Return what we got.
        if $? == 0
          return ret
        else
          return false
        end

      end
    end


    private
    # Very confusing code that generates the shell command.
    def parseopts(cmd, options)
      if options != false
        options.each do |k, v|
          if k != :arg && k != :list_entries
            if v.is_a? Array
              v.each do |vv|
                cmd << " --#{k}='#{vv}'"
              end
            else
              cmd << " --#{k}='#{v}'"
            end
          end
        end

        options[:arg].each { |opt| cmd << " --#{opt}" } if options.has_key?(:arg)
        options[:list_entries].each { |e| cmd << " \"#{e}\"" } if options.has_key?(:list_entries)
      end
      cmd
    end

  end
end

