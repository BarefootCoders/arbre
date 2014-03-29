require 'spec_helper'

describe Arbre do
  let(:helpers) { nil }
  let(:assigns) { {} }

  it 'should render a line graph' do
    arbre {
      ico_line_graph x_axis_values: (29.days.ago.to_date..1.day.ago.to_date).to_a,
        x_axis_formatter: Proc.new { |x| x.strftime("%m/%d") },
        target: 'average_age_of_tickets_chart',
        values: Proc.new { 1 },
        units: ' days'
    }.to_s.chomp.should be
  end
end
