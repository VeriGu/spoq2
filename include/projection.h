#pragma once

namespace autov {
extern unsigned long mono_lens_id;

void spec_transformer(Project *proj, Definition *def, int layer_id, bool unfold = true);
} // namespace autov