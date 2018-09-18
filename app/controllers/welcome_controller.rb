class WelcomeController < ApplicationController

	def index
	    # checks that the state and city params are not empty before calling the API
	    if params[:zipcode].present?
	      response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=#{params[:zipcode]}&units=imperial&appid=#{ENV['openweather_api_key']}")
	      @status = response['cod']
	      # if no error is returned from the call, we fill our instance variables with the result of the call
	      if @status != '404' && response['message'] != 'city not found'
	        @location = response['name']
	        @temp = response['main']['temp']
	        @weather_icon = response['weather'][0]['icon']
	        @weather_words = response['weather'][0]['description']
	        @cloudiness = response['clouds']['all']
	        @windiness = response['wind']['speed']
	        @weather_id = response['weather'][0]['id']
	        # either adds to array or creates new array
	        past_searches = cookies[:past_searches].split(',')
	        past_searches.unshift(params[:zipcode])
	        cookies[:past_searches] = past_searches.uniq.take(5).join(',')

	        set_weather_div

	      else
	        # if there is an error, we report it to our user via the @error variable
	        @error = response['message']
	      end
	    end
	  end


  def test
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=85719&units=imperial&appid=#{ENV['openweather_api_key']}")
    @location = response['name']
    @temp = response['main']['temp']
    @weather_icon = response['weather'][0]['icon']
    @weather_words = response['weather'][0]['description']
    @cloudiness = response['clouds']['all']
    @windiness = response['wind']['speed']
  end

  private

	def set_weather_div

		if @weather_id >= 200 && @weather_id < 300
		@weather_div = "thunderstorm"

		elsif @weather_id >= 300 && @weather_id < 400
		@weather_div = "drizzle"

		elsif @weather_id >= 500 && @weather_id < 600
		@weather_div = "rain"

		elsif @weather_id >= 600 && @weather_id < 700
		@weather_div = "snow"

		elsif @weather_id >= 700 && @weather_id < 800
		@weather_div = "atmosphere"

		elsif @weather_id == 800
		@weather_div = "clear"

		elsif @weather_id >= 801 && @weather_id < 900
		@weather_div = "clouds"

		end

	end

end
