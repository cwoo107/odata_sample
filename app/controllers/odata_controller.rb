class OdataController < ApplicationController

  def test_url
    respond_to do |format|
      format.html { render partial: "loading", locals: { url: params[:url], credentials: params[:credentials]} }
    end
  end
  def process_url
    @url = params[:url]
    @credential = Credential.find(params[:credentials])

    # Simulate processing time
    sleep 2

    # Your actual processing logic would go here
    @result = Odata.process_request(url: @url, username: @credential.username, password: @credential.password)

    respond_to do |format|
      format.html { render partial: "result" }
    end
  end
end
