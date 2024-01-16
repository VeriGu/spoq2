#include <string>
#include <map>
#include <unordered_map>
#include <memory>
#include <irtypes.h>
#include <irvalues.h>
#include <instructions.h>


namespace autov::IRLoader {
	using std::string;
	using std::unordered_map;
	using std::shared_ptr;
	using std::unique_ptr;
	using autov::IRLoader::IRType;
	using autov::IRLoader::Op;
	using autov::IRLoader::Ordering;
	

	const static shared_ptr<IRType> parse_type(shared_ptr<unordered_map<string,string>> typ);
	const static Op parse_op(shared_ptr<unordered_map<string,string>> op);
	const static Ordering parse_ordering(shared_ptr<unordered_map<string,string>> order);
	const static shared_ptr<IRValue> parse_value(shared_ptr<unordered_map<string,string>> val);
	const static shared_ptr<IRInst> parse_instruction(shared_ptr<unordered_map<string,string>> inst, string fname);
};
