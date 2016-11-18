@test "Opening SABnzbd" {
  run curl http://localhost:8080
  [ "${status}" -eq 0 ]
}
