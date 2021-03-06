class ProductsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :decide_products_order, only: ['index']

  # GET /products
  # GET /products.json
  def index
    @products = Product.joins(:artist).order(session[:order_by])
                       .paginate(:page => params[:page])

    @sort_order_selected = session[:order_by]
    #@products = Product.resent(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def index_by_artist_name
    if params[:artist_name]
      @artist = Artist.where(["name = ?", params[:artist_name]]).first
      @products = @artist ? @artist.products : []
     
    else
      @products = []
      
    end

    respond_to do |format|
      format.json { render json: @products}
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html do 
        render :partial => 'product_reviews', :layout => false if request.xhr?
      end# show.html.erb

      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    authorize! :create, @product

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    authorize! :update, @product
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    authorize! :create, @product

    @product.artist = Artist.find_or_initialize_by_name(params[:artist][:name]) 

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    authorize! :update, @product

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    authorize! :destroy, @product
    
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def destroy_checked
    checked_ids = params[:product_ids]

    unless checked_ids.nil?
      begin
        Product.delete_all_by_id(checked_ids)
      rescue
      end
    end

    redirect_to products_url
  end

  def decide_products_order
    session[:order_by] = Product::DEFAULT_ORDER unless session[:order_by]
    session[:order_by] = params[:order_by] if params[:order_by] 
  end


end

