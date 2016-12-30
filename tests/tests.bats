#!/usr/bin/env bats

@test "Opening SABnzbd on port 8080" {
  skip
  run curl -I -s -X GET http://localhost:8080
  [ "$status" -eq 0 ]
}
