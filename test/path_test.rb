

class ResponseGeneratorTest < Minitest::Test
  def test_game_starts_with_good_luck_message
    rg = HTTP::ResponseGenerator.new
    assert_equal "Good Luck!", rg.start_game
  end

  def distributor_initalizes_count_as_zero
    assert_equal 0, @distributor.count
  end
  
  def test_reponse_generator_starts_game_with_game_counter_as_zero
    response_generator = HTTP::ResponseGenerator.new
    response_generator.start_game
    assert_equal 0, response_generator.game_counter
  end

  def test_game_generates_random_number
    rg = HTTP::ResponseGenerator.new
    rg.start_game
    correct_num_one  = rg.correct_number
    rg2 = HTTP::ResponseGenerator.new
    rg2.start_game
    correct_num_two  = rg2.correct_number
    refute correct_num_one == correct_num_two
  end

  def test_game_count_increases_with_first_guess
    rg = HTTP::ResponseGenerator.new
    rg.start_game
    assert_equal 0, rg.game_counter
    rg.guessing_game(47)
    assert_equal 1, rg.game_counter
  end

  def test_game_count_increases_with_second_guess
    rg = HTTP::ResponseGenerator.new
    rg.start_game
    assert_equal 0, rg.game_counter
    rg.guessing_game(47)
    assert_equal 1, rg.game_counter
    rg.guessing_game(19)
    assert_equal 2, rg.game_counter
  end

  def test_prints_out_players_guess
  end

  def test_game_knows_if_its_in_progress
  end

  def test_if_you_start_game_in_progress_will_give_403_error
  end

end
