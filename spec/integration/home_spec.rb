require 'spec_helper'

describe 'home page' do
  it 'should have messsage' do
    visit '/'
    page.should have_content('Request a quote')
  end
end
