require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :name => "Name",
        :genre => "Genre",
        :artist => "Artist"
      ),
      stub_model(Product,
        :name => "Name",
        :genre => "Genre",
        :artist => "Artist"
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Genre".to_s, :count => 2
    assert_select "tr>td", :text => "Artist".to_s, :count => 2
  end
end
