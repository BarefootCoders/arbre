module Arbre
  module Ico
    class LineGraph < Arbre::Component
      require 'json'
      builder_method :ico_line_graph

      def build(attributes = {})
        super
        add_graph_script
      end

      def tag_name
        'script'
      end

      protected
      def add_graph_script
        self.content = %{
          var x_axis = #{x_axis_labels.to_json};

          new Ico.LineGraph(
            "#{get_attribute(:target)}",
            [
              #{values.to_json}
            ],
            {
              colors: ['#{line_color}'],
              curve_amount: #{curve_amount},
              mouseover_attributes: { stroke: '#{mouseover_stroke}' },
              font_size: #{font_size},
              labels: {
                values: x_axis,
                angle: #{x_axis_label_angle}
              },
              x_padding_right: #{x_padding_right},
              units: '#{units}',
              background: {
                color: '#{background_color}',
                corners: #{background_corner_size}
              },
              meanline: #{has_mean_line},
              grid: #{has_grid},
              mouse_pointer: #{has_mouse_pointer},
              status_bar: #{has_status_bar}
            }
          );
        }.html_safe
      end

      DEFAULTS = {
        line_color: '#228899',
        curve_amount: 5,
        mouseover_stroke: 'green',
        font_size: 16,
        x_axis_label_angle: 30,
        x_padding_right: 40,
        units: '',
        background_color: '#ccf',
        background_corner_size: 5,
        has_mean_line: true,
        has_grid: true,
        has_mouse_pointer: true,
        has_status_bar: true
      }

      DEFAULTS.each do |key, value|
        define_method(key) { get_attribute(key) || value }
      end


      def values
        v = get_attribute(:values)
        v = x_axis_values.map(&v) unless v.is_a?(Array)
        v
      end

      def x_axis_labels
        vals = x_axis_values
        formatter = x_axis_formatter
        vals = vals.map(&formatter) if formatter
        vals
      end

      def x_axis_formatter
        get_attribute(:x_axis_formatter)
      end

      def x_axis_values
        get_attribute(:x_axis_values)
      end
    end
  end
end
