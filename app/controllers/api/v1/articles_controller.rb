module Api
	module V1
        class ArticlesController < ApplicationController   
            # Listar todos os artigos
			def index
				articles = Article.order('created_at DESC');
				render json: {status: 'SUCCESS', message:'Artigos carregados', data:articles},status: :ok
            end
            
            # Listar artigo passando ID
			def show
				article = Article.find(params[:id])
				render json: {status: 'SUCCESS', message:'Loaded article', data:article},status: :ok
            end
            
            # Criar um novo artigo
			def create
				article = Article.new(article_params)
				if article.save
					render json: {status: 'SUCCESS', message:'Saved article', data:article},status: :ok
				else
					render json: {status: 'ERROR', message:'Articles not saved', data:article.erros},status: :unprocessable_entity
				end
            end
            
            # Atualizar um artigo
			def update
				article = Article.find(params[:id])
				if article.update_attributes(article_params)
					render json: {status: 'SUCCESS', message:'Updated article', data:article},status: :ok
				else
					render json: {status: 'ERROR', message:'Articles not update', data:article.erros},status: :unprocessable_entity
				end
            end
            
            # Excluir artigo
			def destroy
				article = Article.find(params[:id])
				article.destroy
				render json: {status: 'SUCCESS', message:'Deleted article', data:article},status: :ok
			end

			# Parametros aceitos
			private
			def article_params
				params.permit(:title, :body)
			end
		end
	end
end