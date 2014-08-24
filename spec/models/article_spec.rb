require'spec_helper'

describe Article do
	
	it 'is valid with a user, title and body' do
		article = FactoryGirl.build(:article)
		expect(article).to be_valid
	end

	it 'is invalid without a title' do
		expect(FactoryGirl.build(:article, title: nil)).to have(1).errors_on(:title)
		expect(FactoryGirl.build(:article, title: "")).to have(1).errors_on(:title)
	end

	it 'is invalid without a body' do
		no_body_article = FactoryGirl.build(:article, body: nil)
		
		# Validate class to create errors and then print errors
		no_body_article.valid?
		no_body_article.errors.each do |attr,msg| 
			#puts "#{attr} - #{msg}"
		end

		expect(no_body_article).to have(1).errors_on(:body)
	end

	it 'is invalid without a user' do
		article = FactoryGirl.build(:article, user_id: nil)

		expect(article).not_to be_valid
	end

	it "returns an articles's long name as a string" do
		article = FactoryGirl.build(:article, published_at: "2013-10-21" )

		expect(article.published?).to be_true
		expect(article.long_title).to eq('Test Article1 Title - 2013-10-21 00:00:00 UTC')
	end

	describe "filter articles by title" do
		before :each do
			@user1 = FactoryGirl.create(:user)
			@article1 = FactoryGirl.create(:article, user_id: @user1.id, title: 'Polly prissypants')
			@article2 = FactoryGirl.create(:article, user_id: @user1.id, title: 'Nonsense Article')
			@article3 = FactoryGirl.create(:article, user_id: @user1.id, title: 'Pork Article')
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