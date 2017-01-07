#!/usr/bin/env bats

@test "Opening SABnzbd on port 8080" {
  skip
  curl -I -s -X GET http://localhost:8080 |grep 302
  [ "$status" -eq 0 ]
}
