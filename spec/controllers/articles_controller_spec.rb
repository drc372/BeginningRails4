require'spec_helper' 

describe ArticlesController do
	describe 'GET #index' do
		it "populates an array of all articles" do
			article1 = FactoryGirl.create(:article, title:"ArticleTitle1")
			article2 = FactoryGirl.create(:article, title:"ArticleTitle2")
			expected_list = [article1, article2]

			get :index 

			expect(assigns(:articles)).to match_array(expected_list)
		end

		it "renders the :index template" do
			get :index
			expect(response).to render_template :index
		end
	end
		
	describe 'GET #show' do
		it "assigns the requested article to @article" do
			article = FactoryGirl.create(:article)
  	  get :show, id: article
	    expect(assigns(:article)).to eq article
		end

		it "renders the :show template" do
			article = FactoryGirl.create(:article)
			get :show, id: article 
			expect(response).to render_template :show
		end
	end
	
	describe 'GET #new' do
		before :each do
    	@user = FactoryGirl.create(:user)
			session[:user_id] = @user.id
		end

		it "assigns a new Article to @article" do
			get :new
			expect(assigns(:article)).to be_a_new(Article)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end
		
	describe 'GET #edit' do
		before :each do
    	@user = FactoryGirl.create(:user)
			session[:user_id] = @user.id
		end

		it "assigns the requested article to @article" do
			article = FactoryGirl.create(:article, user_id: @user.id)
    	get :edit, id: article
    	expect(assigns(:article)).to eq article
		end

		it "renders the :edit template" do
			article = FactoryGirl.create(:article, user_id: @user.id)
    	get :edit, id: article
    	expect(response).to render_template :edit
		end
	end
		
	describe "POST #create" do
		before :each do
    	@user = FactoryGirl.create(:user)
			session[:user_id] = @user.id
		end

		context "with valid attributes" do
      it "saves the new article in the database" do
      	article_attrs = FactoryGirl.attributes_for(:article)
      	expect{post :create, article: article_attrs}.to change(Article, :count).by(1)
      end

			it "redirects to article#show" do
				article_attrs = FactoryGirl.attributes_for(:article)
      	post :create, article: article_attrs
      	expect(response).to redirect_to article_path(assigns[:article])
			end
		end
		
		context "with invalid attributes" do
			it "does not save the new article in the database" do
				article_attrs = FactoryGirl.attributes_for(:invalid_article)
		    expect{post :create, article: article_attrs}.to change(Article, :count).by(0)
			end

			it "re-renders the :new template" do
				article_attrs = FactoryGirl.attributes_for(:invalid_article)
				post :create, article: article_attrs
				expect(response).to render_template :new
			end
		end 
	end
		
	describe 'PATCH #update' do
		before :each do
			@user = FactoryGirl.create(:user)
			session[:user_id] = @user.id

    	@article = FactoryGirl.create(:article, user_id: @user.id, title: 'Update Test', 
    																body: 'Update test body')
		end

		context "with valid attributes" do
			it "locates the requested @article" do
      	patch :update, id: @article, article: FactoryGirl.attributes_for(:article)
				expect(assigns(:article)).to eq(@article) 
			end

  		it "updates the article in the database" do

  		end
  		it "redirects to the article"
  	end
		
		context "with invalid attributes" do 
			it "does not update the article" 
			it "re-renders the #edit template"
		end 
	end

	describe 'DELETE #destroy' do
		it "deletes the article from the database" 
		it "redirects to article#index"
	end 
end