#include "my_lib/my_lib.hpp"

#include <httplib.h>

void foo() {
  httplib::Client cli("");
  cli.enable_server_certificate_verification(false);
}
