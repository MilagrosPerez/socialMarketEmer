class ProductsController < ApplicationController
    skip_before_action :protect_pages, only: [:show , :index]

    def index
        # @products = Product.with_attached_photo
        #
        # # Aplicar filtros si existen
        # if params[:query_text].present?
        #     query = "%#{params[:query_text].downcase}%"
        #     @products = @products.where('LOWER(title) LIKE ? OR LOWER(description) LIKE ?', query, query)
        # end
        #
        # if params[:min_price].present?
        #     @products = @products.where('price >= ?', params[:min_price])
        # end
        #
        # if params[:max_price].present?
        #     @products = @products.where('price <= ?', params[:max_price])
        # end
        #
        # if params[:category_id]
        #     @products = @products.where(category_id: params[:category_id])
        # end
        #
        #
        #
        # @products = @products.order(order_by).load_async

        # Paginación
        @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 2)
        @categories = Category.all.order(name: :asc).load_async
    end

    def show
        product
    end

    def new
        #Le paso una instancia vacia
        @product = Product.new
    end

    def create
        #@product = Current.user.products.new(product_params)
        # se cambia a metodo de asignar el usuario logeado directamente en el modelo
        @product = Product.new(product_params)
        if @product.save
            redirect_to products_path, notice: t('.created')
        else
            #Renderizo de nuevo y ademas envio un codigo http 422 que se usa cuando no se pudo crear
            render :new, status: :unprocessable_entity
        end
        
    end

    def edit
        authorize! product
        #le paso la instancia indexada por el param de la url
    end

    def update
        authorize! product
        if product.update(product_params)
            redirect_to products_path, notice: t('.updated')
        else
            #Renderizo de nuevo y ademas envio un codigo http 422 que se usa cuando no se pudo actualizar
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        authorize! product
        if product.destroy
            #por defecto el redirect_to manda un 302 , se debe sobreescribir ese codigo porque sino turbo se confunde
            redirect_to products_path, notice: t('.destroyed'), status: :see_other
        else
            #Renderizo de nuevo y ademas envio un codigo http 422 que se usa cuando no se pudo actualizar
            render :new, status: :unprocessable_entity
        end
    end

    #Se definie una funcion privada que toma los datos que se envian en el post .
    #le digo que los parametros deben tener un producto y que columnas permito
    private
    def product_params
        params.require(:product).permit(:title, :description, :price , :photo , :category_id)
    end

    def product_params_index
        params.permit(:query_text,
                      :max_price,
                      :min_price,
                      :category_id,
                      :order_by,
                      :page,
                      :locale,
                      :favorites,
                      :user_id)
    end

    def product
        @product ||= Product.find(params[:id])
    end
end