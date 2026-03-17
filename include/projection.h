#pragma once

namespace autov {
extern unsigned long mono_lens_id;
void spec_transformer_v2(Project *proj, Definition *def, int layer_id, bool unfold, bool low_spec = true, int max_iter=50000);
unique_ptr<SpecNode> spec_transformer_v2(Project *proj, unique_ptr<SpecNode> node, int layer_id, bool unfold, bool low_spec);
void spec_transformer(Project *proj, Definition *def, int layer_id, bool unfold = true, bool low_spec=true);
} // namespace autov