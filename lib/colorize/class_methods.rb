module Colorize
  module ClassMethods

    #
    # Color codes hash
    #
    def color_codes
      {
        :black   => 0, :light_black    => 60,
        :red     => 1, :light_red      => 61,
        :green   => 2, :light_green    => 62,
        :yellow  => 3, :light_yellow   => 63,
        :blue    => 4, :light_blue     => 64,
        :magenta => 5, :light_magenta  => 65,
        :cyan    => 6, :light_cyan     => 66,
        :white   => 7, :light_white    => 67,
        :default => 9
      }
    end

    #
    # Return array of available colors used by colorize
    #
    def colors
      color_codes.keys.sort
    end

    #
    # Mode codes hash
    #
    def mode_codes
      {
        :default   => 0, # Turn off all attributes
        :bold      => 1, # Set bold mode
        :underline => 4, # Set underline mode
        :blink     => 5, # Set blink mode
        :swap      => 7, # Exchange foreground and background colors
        :hide      => 8  # Hide text (foreground color would be the same as background)
      }
    end

    #
    # Return array of available modes used by colorize
    #
    def modes
      mode_codes.keys
    end

    #
    # Color and on_color methods
    #
    def color_methods
      colors.each do |key|
        next if key == :default

        define_method key do
          colorize(:color => key)
        end

        define_method "on_#{key}" do
          colorize(:background => key)
        end
      end
    end

    #
    # Modes methods
    #
    def modes_methods
      modes.each do |key|
        next if key == :default

        define_method key do
          colorize(:mode => key)
        end
      end
    end

    #
    # Display color samples
    #
    def color_samples
      colors.permutation(2).each do |background, color|
        sample_text = "#{color.inspect.rjust(15)} on #{background.inspect.ljust(15)}"
        puts "#{sample_text.colorize(:color => color, :background => background)} #{sample_text}"
      end
    end

    #
    # Method removed, raise NoMethodError
    #
    def color_matrix(txt = '')
      fail NoMethodError, '#color_matrix method was removed, try #color_samples instead'
    end
  end
end