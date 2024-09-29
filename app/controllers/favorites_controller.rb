class FavoritesController < ApplicationController

  def index

  end

  def create
    product.favorite!
    # Lo de arriba es lo mismo que lo de abajo, arriba se hace con scooping
    # Favorite.create(product: product, user: Current.user)

    #Para responder con mas de un tipo (por defecto se responde con html)
    respond_to do |format|
      format.html do
        redirect_to product_path(product)
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product} )
      end
    end
  end

  def destroy
    product.unfavorite!
    respond_to do |format|
      format.html do
        redirect_to product_path(product), status: :see_other
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product} )
      end
    end
  end

  private
  #memoriza el contendio osea cachea para no tener que busca de nuevo
  def product
    @product ||= Product.find(params[:product_id])
  end
end