
#pragma once

#include <project.h>
#include <nodes.h>

namespace autov {
bool decompose(Project* proj, Definition* def, const string& secret = "g_norm");
}