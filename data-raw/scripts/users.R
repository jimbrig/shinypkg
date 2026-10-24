
#  ------------------------------------------------------------------------
#
# Title : Demo Users Data
#    By : Jimmy Briggs
#  Date : 2026-10-07
#
#  ------------------------------------------------------------------------

demo_users <- tibble::tibble(
  user_id = c(1:5),
  user_name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  user_email = c("alice@example.com", "bob@example.com", "charlie@example.com", "david@example.com", "eve@example.com"),
  user_role = c("admin", "user", "user", "guest", "admin"),
  user_status = c("active", "active", "active", "inactive", "active")
)
