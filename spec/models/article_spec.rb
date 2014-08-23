require'spec_helper'

describe Article do
	
	before :each do
      @user1 = User.create(email: "dan@email.com", password:"Password1", password_confirmation:"Password1")
	end
	
	it 'is valid with a user, title and body' do
		article = @user1.articles.new(
			title: 'Testing Article',
			body: 'This is the body for the valid test article')
		expect(article).to be_valid
	end

	it 'is invalid without a title' do
		expect(@user1.articles.new(title: nil, body: 'Body without title')).to have(1).errors_on(:title)
		expect(Article.new(user_id: @user1.id, title: "", body: 'Body without title2')).to have(1).errors_on(:title)
	end

	it 'is invalid without a body' do
		no_body_article = @user1.articles.new(title: 'No body article', body: nil)
		
		# Validate class to create errors and then print errors
		no_body_article.valid?
		no_body_article.errors.each do |attr,msg| 
			#puts "#{attr} - #{msg}"
		end

		expect(no_body_article).to have(1).errors_on(:body)
	end

	it 'is invalid without a user' do
		article = Article.new(
			title: 'Testing Article',
			body: 'This is the body for the valid test article')

		expect(article).not_to be_valid
	end

	it "returns an articles's long name as a string" do
		article = @user1.articles.new(
			title: 'Testing Article',
			body: 'This is the body for the valid test article',
			published_at: "2013-10-21" )

		expect(article.published?).to be_true
		expect(article.long_title).to eq('Testing Article - 2013-10-21 00:00:00 UTC')
	end

	describe "filter articles by title" do
		before :each do
			@article1 = @user1.articles.create(
				title: 'Polly prissypants',
				body: 'We gonna talk all about polly prissypants',
				published_at: "2014-02-01" )

			@article2 = @user1.articles.create(
				title: 'Nonsense Article',
				body: 'This article is nonsense',
				published_at: "2014-01-11" )

			@article3 = @user1.articles.create(
				title: 'Pork Article',
				body: 'This article loves bacon and ribs',
				published_at: "2011-10-25" )
		end

		context "matching titles" do
			it "returns array of articles with titles that start with letter" do
				articles = @user1.articles.where_title("P")
				expect(articles.size).to eq(2)

				article_titles = []
				articles.each {|art| article_titles.push(art.title)}
				# puts article_titles

				expect(article_titles).to eq(['Polly prissypants', 'Pork Article'])
			end
		end

		context "did not match titles" do
			it "returns array of articles that match" do
				articles = @user1.articles.where_title("Nonsense")
				expect(articles.size).to eq(1)
				expect(articles).not_to include(@article1)
			end
		end
	end
end