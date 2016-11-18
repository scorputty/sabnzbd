@test "Opening SABnzbd on port 8080" {
  run curl http://localhost:8080
  [ "${status}" -eq 0 ]
}
