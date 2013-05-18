class ReviewsController < ApplicationController

  before_filter :authenticate_user!

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new

    authorize! :create, @review

    respond_to do |format|
      format.html do
        render :partial => 'form', :layout => false if request.xhr?
      end
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])

    authorize! :update, @review
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(params[:review])
    @product = Product.find(params[:product_id]) 
    @review.product = @product
    @review.user = current_user

    authorize! :create, @review

    respond_to do |format|
      if @review.save
        format.html do
          if request.xhr?
            render :text => ''
          else
            redirect_to @product, notice: 'Review was successfully created.' 
          end
        end

        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])

    authorize! :update, @review

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @product, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    authorize! :destroy, @review

    @review.destroy

    respond_to do |format|
      format.html { redirect_to @product }
      format.json { head :no_content }
    end
  end
end
