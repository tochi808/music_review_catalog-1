require 'spec_helper'

describe "reviews/new" do
  before(:each) do
    assign(:review, stub_model(Review,
      :body => "MyText",
      :product_id => 1
    ).as_new_record)
  end

  it "renders new review form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reviews_path, :method => "post" do
      assert_select "textarea#review_body", :name => "review[body]"
      assert_select "input#review_product_id", :name => "review[product_id]"
    end
  end
end
