class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # The following four lines ensure that Ruby does not count linefeeds or carriage returns.
    text_wo_space = @text.gsub(" ","")
    text_wo_feed_or_return = @text.gsub("\n","").gsub("\t","")
    text_wo_space_linefeed = text_wo_space.gsub("\n","")
    text_wo_space_linefeed_carriagereturn = text_wo_space_linefeed.gsub("\r","")
    text_wo_all_including_tabs = text_wo_space_linefeed_carriagereturn.gsub("\t","")

    @character_count_with_spaces = text_wo_feed_or_return.length

    words_separated = @text.split
    @word_count = words_separated.length

    @character_count_without_spaces = text_wo_all_including_tabs.length

    # This uses .each to check if each word in new array equals special word
    count_of_special_word = []
    words_separated.each do |word|
      if word == @special_word
        count_of_special_word.push(word)
      end
    end
    @occurrences = count_of_special_word.count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_rate = @apr/100/12
    months = @years*12

    @monthly_payment = @principal*(monthly_rate*(1+monthly_rate)**months)/((1+monthly_rate)**months-1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    if @sorted_numbers.count%2 != 0
      @median = @sorted_numbers[(@sorted_numbers.count-1)/2]
    else
      @median = (@sorted_numbers[@sorted_numbers.count/2]+@sorted_numbers[(@sorted_numbers.count/2)-1])/2
    end

    @sum = @sorted_numbers.sum

    @mean = @sorted_numbers.sum/@sorted_numbers.count

    sum_of_all_diff = []
    @sorted_numbers.each do |num|
      diff_from_mean = (num - @mean)**2
      sum_of_all_diff.push(diff_from_mean)
    end
    @variance = sum_of_all_diff.sum/(@sorted_numbers.count-1)

    @standard_deviation = @variance**0.5

    @mode = "need to finish"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
