require_relative 'git_metrics'
require 'test/unit'

class TestGitMetrics < Test::Unit::TestCase

  def test_commit_example
        assert_equal 2, num_commits(["commit abc", "commit 123"]), "Should have counted two commits"
  end

  def test_dates_with_three_days
        exp = [ "Date:  Sun Jan 26 21:25:22 2014 -0600", \
                        "Date:  Sun Jan 23 21:25:22 2014 -0600", \
                        "Date:  Sun Jan 25 21:25:22 2014 -0600"]
    assert_equal 4, days_of_development(exp), "Should have been a 3 days difference"
  end

  def test_dates_one_year
    exp = ["Date:  Sun Jan 26 21:25:22 2014 -0600", \
           "Date:  Sun Jan 26 21:25:22 2013 -0600"]
    assert_equal 366, days_of_development(exp), "Should have been 366 days"
  end

  def test_dates_two_years_two_days
    exp = ["Date:  Sun Jan 26 21:25:22 2014 -0600", \
           "Date:  Sun Jan 24 21:25:22 2012 -0600"]
    assert_equal 734, days_of_development(exp), "Should have been 734 days"
  end

  def test_commit_many
    exp = ["commit last", "commit first", "commit middle", "commit middle second", \
           "commit for fun", "commit fixing stuff","commit 7",  "commit 8", \
           "commit 9", "commit 10", "commit 11", "commit 12", "commit 13", "commit 14", \
           "commit 15", "commit 16", "commit 17", "commit 18"]
    assert_equal 18, num_commits(exp), "Should have counted 18 commits"
  end

  def test_one_email
    assert_equal 1, num_developers(["Author: Dan <dantheman@gmail.com>"]),\
        "Should have counted one developer"
  end

  def test_multiple_emails_per_name
    exp = ["Author: Dan <dantheman@gmail.com>", "Author: Dan <dantheman@yahoo.com>",\
           "Author: Dan <dantheman@gmail.com>", "Author: Dan <dantheman@rit.edu>", \
           "Author: Dan <dantheman@aol.com>", "Author: Dan <dan277@gmail.com>"]
    assert_equal 5, num_developers(exp), "Should have counted 5 developers"
  end
end

