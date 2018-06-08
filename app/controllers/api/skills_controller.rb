class Api::SkillsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @skills = Competence.all
  end

  # def create
  #   @post = Post.new(content: params[:content])
  #   if @post.save
  #     render json: @post, status: :created
  #   else
  #     render json: @post.errors, status: :bad_request
  #   end
  # end
  #
  # def update
  #   @post = Post.find(params[:id])
  #   if @post.update(post_params)
  #     render json: @post
  #   end
  # end
  #
  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end
end
