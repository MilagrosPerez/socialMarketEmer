class CategoryPolicy < BasePolicy
  #Aca abajo va lo que va a proteger CategoryPolicy
  def index
    Current.user.admin?
  end
  def new
    Current.user.admin?
  end
  def create
    Current.user.admin?
  end
  def edit
    Current.user.admin?
  end
  def update
    Current.user.admin?
  end
  def destroy
    Current.user.admin?
  end

end