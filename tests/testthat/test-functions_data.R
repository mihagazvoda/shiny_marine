source("../../R/packages.R")
source("../../R/functions_data.R")

# run out of time for more tests and test cases
describe("agg_ship_data()", {
  it("works on simulated data for equal distances", {
    test_data <- tribble(
      ~ship_type, ~ship_id, ~datetime, ~lat, ~lon,
      "A", "X", 1L, 0, 0,
      "A", "X", 2L, 1, 0,
      "A", "X", 3L, 2, 0
    )

    result_data <- tribble(
      ~ship_type, ~ship_id, ~lat, ~lon, ~lat_next, ~lon_next, ~dist,
      "A", "X", 0, 0, 1, 0, 111319
    )

    expect_equal(
      agg_ship_data(test_data),
      result_data,
      tolerance = 1e-3
    )
  })
})
