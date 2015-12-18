class Minitest::Test
  def setup
    DatabaseRewinder.clean_all
  end

  def teardown
    DatabaseRewinder.clean
  end
end
