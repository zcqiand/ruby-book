def destroy
  @post = current_user.posts.find(params[:id])
  @post.destroy
  redirect_to posts_path
end