// Compiled using g++ -std=c++11 -DBOOST_LOG_DYN_LINK test_log.cpp -o test_log -lboost_log -lboost_log_setup -lboost_thread -lboost_system
#include <boost/log/trivial.hpp>
#include <boost/log/utility/setup/console.hpp>
#include <boost/log/utility/setup/common_attributes.hpp>
#include <boost/log/expressions.hpp>
#include <boost/log/support/date_time.hpp>
#include <boost/log/core.hpp>
#include <boost/log/sinks/sync_frontend.hpp>
#include <boost/log/sinks/text_ostream_backend.hpp>
#include <boost/algorithm/string.hpp>

namespace logging = boost::log;
namespace sinks = boost::log::sinks;
namespace expr = boost::log::expressions;
namespace keywords = boost::log::keywords;

namespace boost {
namespace log {
namespace trivial {

std::ostream& operator<<(std::ostream& strm, severity_level level) {
    static const char* strings[] = {
        "???", "DBG", "INF", "WRN", "ERR"
    };

    std::size_t level_index = static_cast<std::size_t>(level);

    if (level_index < sizeof(strings) / sizeof(*strings)) {
        strm << strings[level_index];
    } else {
        strm << "???";
    }

    return strm;
}

} // namespace trivial
} // namespace log
} // namespace boost

namespace autov {
namespace log {

// expr::stream_type& operator<<(expr::stream_type& strm, boost::log::trivial::severity_level level) {
//     static const char* strings[] = {
//         "DBG", "INF", "WRN", "ERR"
//     };

//     std::size_t level_index = static_cast<std::size_t>(level);

//     std::cout << "level_index: " << level_index << std::endl;
//     //strm << strings[level_index];
//     if (level_index < sizeof(strings) / sizeof(*strings)) {
//         strm << strings[level_index];
//     } else {
//         strm << static_cast<int>(level);
//     }

//     return strm;
// }

void set_logging_level() {
#ifdef DEBUG
    logging::core::get()->set_filter
    (
        logging::trivial::severity >= logging::trivial::debug
    );
#else
    logging::core::get()->set_filter
    (
        logging::trivial::severity >= logging::trivial::info
    );
#endif
}

void init() {
    logging::add_common_attributes();

    // Formatter for the timestamp
    auto fmtTimeStamp = expr::format_date_time<boost::posix_time::ptime>("TimeStamp", "%H:%M:%S");


    // Console sink for non-error messages
    auto console_sink = logging::add_console_log(
        std::cout,
        keywords::filter = expr::attr<logging::trivial::severity_level>("Severity") < logging::trivial::error,
        keywords::format = (
            expr::stream
                << fmtTimeStamp
                << " [" <<  expr::attr<logging::trivial::severity_level>("Severity").or_default(logging::trivial::trace)
                << "]: " << expr::smessage
        )
    );

    // Console sink for error messages
    typedef sinks::synchronous_sink<sinks::text_ostream_backend> text_sink;
    boost::shared_ptr<text_sink> error_sink = boost::make_shared<text_sink>();

    error_sink->locked_backend()->add_stream(boost::make_shared<std::ostream>(std::cerr.rdbuf()));
    error_sink->set_filter(logging::trivial::severity >= logging::trivial::error);
    error_sink->set_formatter(
        expr::stream
            << fmtTimeStamp
            << " [" <<  expr::attr<logging::trivial::severity_level>("Severity").or_default(logging::trivial::trace)
            << "]: " << expr::smessage
    );

    logging::core::get()->add_sink(error_sink);
}
}
} // namespace autov