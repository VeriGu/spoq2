/* The exit status a test binary returns when the only thing it found was a
 * feature that is not implemented yet.
 *
 * CMake gives every ctest entry SKIP_RETURN_CODE = SPOQ_SKIP_RETURN_CODE, so
 * ctest reports those runs as "Skipped" rather than passed or failed.  The point
 * is that a test for an unimplemented feature asserts what the feature *should*
 * do: it cannot quietly turn into a record of the current wrong answer, and it
 * starts failing -- telling you to drop the marker -- the day the feature lands.
 *
 * 77 is the autotools convention for the same thing.
 */
#pragma once

#include <gtest/gtest.h>

#ifndef SPOQ_SKIP_RETURN_CODE
#define SPOQ_SKIP_RETURN_CODE 77
#endif

namespace spoq_test {

/// [status] from RUN_ALL_TESTS, mapped to the skip code when every test that
/// ran was skipped.  A run with even one real result reports that instead.
inline int skip_aware_status(int status) {
    const auto &ut = *::testing::UnitTest::GetInstance();
    if (status == 0 && ut.test_to_run_count() > 0 &&
        ut.skipped_test_count() == ut.test_to_run_count())
        return SPOQ_SKIP_RETURN_CODE;
    return status;
}

}  // namespace spoq_test
