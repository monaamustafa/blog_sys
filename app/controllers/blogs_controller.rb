class BlogsController < ApplicationController
    before_action :set_blog, only: [:edit, :update, :show, :destroy]

    before_action :require_user, except: [:index, :show]
    
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def  index
        @blog=Blog.all
    
    end
    def new
     @blog = Blog.new
    end
    def create
        @blog = Blog.new(blog_params)
        @blog.user = current_user
         if @blog.save
            flash[:notice]="new blog was added succesfully"
            redirect_to blog_path(@blog)
         else 
            render "new"    
            # redirect_to blogs_show(@blog)
    
        end    

    end    
    def show 
        @blog=Blog.find(params[:id])
    end    
        
    def edit
        @blog=Blog.find(params[:id])
    end
    def update
        @blog=Blog.find(params[:id])
        if @blog.update(blog_params)
            flash[:notice]="new blog was updated succesfully"
            redirect_to blog_path(@blog)
         else 
            render "edit"    
            # redirect_to blogs_show(@blog)
        end 
    end
    def destroy

        @blog = Blog.find(params[:id])
        
        @blog.destroy
        
        flash[:notice] = "blog was successfully deleted"
        
        redirect_to blogs_path
        
    end
    private 
         def set_blog

            @blog = Blog.find(params[:id])
        
        end
        
        
        def require_same_user
        
            if current_user != @blog.user
        
                flash[:danger] = "You can only edit or delete your own blogs"
        
                redirect_to root_path
        
            end
        
        end
        
        def blog_params
             params.require(:blog).permit(:title, :description)
        end        
end