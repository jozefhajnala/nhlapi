context("nhl_url_add_params")

testthat::test_that(
  "Add 1 param to an URL with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474",
      list(par = "1")
    ),
    "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1"
  )
)

testthat::test_that(
  "Add 2 params to an URL with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474",
      list(par = "1", par2 = "2")
    ),
    "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1&par2=2"
  )
)

testthat::test_that(
  "Add 2 params to an URL with params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?par1=1",
      list(par2 = "2", par3 = "3")
    ),
    "https://statsapi.web.nhl.com/api/v1/people/8477474?par1=1&par2=2&par3=3"
  )
)

testthat::test_that(
  "Add 1 param to 2 urls with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      c(
        "https://statsapi.web.nhl.com/api/v1/people/8477474",
        "https://statsapi.web.nhl.com/api/v1/people/8477475"
      ),
      params = c(par = "1")
    ),
    c(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1",
      "https://statsapi.web.nhl.com/api/v1/people/8477475?par=1"
    )
  )
)

testthat::test_that(
  "Add 2 params to 2 urls with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      c(
        "https://statsapi.web.nhl.com/api/v1/people/8477474",
        "https://statsapi.web.nhl.com/api/v1/people/8477475"
      ),
      params = list(par = "1", par2 = "2")
    ),
    c(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1&par2=2",
      "https://statsapi.web.nhl.com/api/v1/people/8477475?par=1&par2=2"
    )
  )
)

testthat::test_that(
  "Add 1 param to 2 urls, one having params already",
  testthat::expect_equal(
    nhl_url_add_params(
      c(
        "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1",
        "https://statsapi.web.nhl.com/api/v1/people/8477475"
      ),
      params = list(par2 = "2")
    ),
    c(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1&par2=2",
      "https://statsapi.web.nhl.com/api/v1/people/8477475?par2=2"
    )
  )
)

testthat::test_that(
  "Add 1 param with multiple values to 2 urls, one having params already",
  testthat::expect_equal(
    nhl_url_add_params(
      c(
        "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1",
        "https://statsapi.web.nhl.com/api/v1/people/8477475"
      ),
      params = list(par2 = c("20", "21"))
    ),
    c(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1&par2=20",
      "https://statsapi.web.nhl.com/api/v1/people/8477475?par2=20",
      "https://statsapi.web.nhl.com/api/v1/people/8477474?par=1&par2=21",
      "https://statsapi.web.nhl.com/api/v1/people/8477475?par2=21"
    )
  )
)

testthat::test_that(
  "Add 1 param with multiple large values to 2 urls, 1 having params already",
  testthat::expect_equal(
    nhl_url_add_params(
      c(
        "https://statsapi.web.nhl.com/api/v1/people/10000?par=1",
        "https://statsapi.web.nhl.com/api/v1/people/20000"
      ),
      params = list(par2 = c(100000000, 200000000))
    ),
    c(
      "https://statsapi.web.nhl.com/api/v1/people/10000?par=1&par2=100000000",
      "https://statsapi.web.nhl.com/api/v1/people/20000?par2=100000000",
      "https://statsapi.web.nhl.com/api/v1/people/10000?par=1&par2=200000000",
      "https://statsapi.web.nhl.com/api/v1/people/20000?par2=200000000"
    )
  )
)

testthat::test_that(
  "Add integer seasons param to an URL with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474",
      list(season = 2000)
    ),
    "https://statsapi.web.nhl.com/api/v1/people/8477474?season=20002001"
  )
)

testthat::test_that(
  "Add integer seasons param to an URL with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474",
      list(season = 2000:2001)
    ),
    paste0(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?season=",
      c("20002001", "20012002")
    )
  )
)

testthat::test_that(
  "Add non-adjacent integer seasons param to an URL with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474",
      list(season = c(2000, 2010))
    ),
    paste0(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?season=",
      c("20002001", "20102011")
    )
  )
)

testthat::test_that(
  "Add non-adjacent character seasons param to an URL with no params",
  testthat::expect_equal(
    nhl_url_add_params(
      "https://statsapi.web.nhl.com/api/v1/people/8477474",
      list(season = c("20002001", "20102011"))
    ),
    paste0(
      "https://statsapi.web.nhl.com/api/v1/people/8477474?season=",
      c("20002001", "20102011")
    )
  )
)