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
		context "with valid attributes" do
		      it "saves the new article in the database"
					it "redirects to article#show" 
		end
		
		context "with invalid attributes" do
			it "does not save the new article in the database" 
			it "re-renders the :new template"
		end 
	end
		
	describe 'PATCH #update' do
		context "with valid attributes" do
  		it "updates the article in the database"
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