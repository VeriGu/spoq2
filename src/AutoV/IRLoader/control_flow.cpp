#include <control_flow.h>
#include <set>
#include <cassert>
#include <log.h>
#include <algorithm>

namespace autov::IRLoader {

class Node {
public:
    vector<shared_ptr<IRInst>> insts;
    int scc;
    std::set<string> loop_use;
    shared_ptr<IRInst> last_inst;
};

class Backward;
class Edge {
public:
    string next;
    shared_ptr<IRValue> cond;
    vector<shared_ptr<IRInst>> insts;
    shared_ptr<Backward> backward;

    Edge() = default;
    Edge(string next, shared_ptr<IRValue> cond, vector<shared_ptr<IRInst>> insts) : next(next), cond(cond), insts(insts) {}
};

class Backward {
public:
    string from;
    shared_ptr<Edge> edge;

    Backward() = default;
    Backward(string from, shared_ptr<Edge> edge) : from(from), edge(edge) {}
};

template<typename KeyType, typename ValueType>
class dict {
public:
    // Insert a key-value pair
    void insert(const KeyType& key, const ValueType& value) {
        auto it = map.find(key);
        if (it != map.end()) {
            it->second->second = value; // Update the value if key exists
            return;
        }
        order.push_back(std::make_pair(key, value));
        map[key] = std::prev(order.end()); // Store iterator to the list element
    }

    // Check if the map contains a key
    bool contains(const KeyType& key) const {
        return map.find(key) != map.end();
    }

    // Get value associated with a key
    // Note: This function does not handle the case where the key does not exist.
    // In a complete implementation, you might want to throw an exception or return a default value.
    ValueType& get(const KeyType& key) {
        return map[key]->second;
    }

    const ValueType& get(const KeyType& key) const {
        return map.at(key)->second;
    }

    // Remove a key-value pair
    void erase(const KeyType& key) {
        auto it = map.find(key);
        if (it != map.end()) {
            order.erase(it->second);
            map.erase(it);
        }
    }

    size_t size() const {
        return map.size();
    }

    bool empty() const {
        return map.empty();
    }

    // Function to print the map
    void print() const {
        for (const auto& pair : order) {
            std::cout << pair.first << ": " << pair.second << std::endl;
        }
    }
    // 'operator[]' for non-const objects
    ValueType& operator[](const KeyType& key) {
        auto it = map.find(key);
        if (it != map.end()) {
            return it->second->second;
        }
        // If key is not found, insert a new default-constructed value and return a reference to it
        order.push_back({key, ValueType()});
        auto insertedElement = std::prev(order.end());
        map[key] = insertedElement;
        return insertedElement->second;
    }

    // 'operator[]' for const objects
    const ValueType& operator[](const KeyType& key) const {
        auto it = map.find(key);
        if (it != map.end()) {
            return it->second->second;
        }
        // This behavior is a bit tricky because 'operator[]' usually doesn't exist for const maps,
        // as it might need to modify the map. We throw an exception in this case.
        throw std::runtime_error("Key not found");
    }

    class iterator {
    public:
        using value_type = std::pair<const KeyType, ValueType>;
        using iterator_category = std::forward_iterator_tag;
        using difference_type = std::ptrdiff_t;
        using pointer = value_type*;
        using reference = value_type&;

        iterator(typename std::list<std::pair<KeyType, ValueType>>::iterator it) : it(it) {}

        // Operator* returns a pair<const KeyType, ValueType>&
        reference operator*() const {
            return reinterpret_cast<reference>(*it);
        }

        // Operator-> returns a pointer to the pair
        pointer operator->() const {
            return reinterpret_cast<pointer>(&(*it));
        }

        // Pre-increment
        iterator& operator++() {
            ++it;
            return *this;
        }

        // Post-increment
        iterator operator++(int) {
            iterator temp = *this;
            ++(*this);
            return temp;
        }

        friend bool operator==(const iterator& a, const iterator& b) {
            return a.it == b.it;
        }

        friend bool operator!=(const iterator& a, const iterator& b) {
            return a.it != b.it;
        }

    private:
        typename std::list<std::pair<KeyType, ValueType>>::iterator it;
    };

    // Begin iterator
    iterator begin() {
        return iterator(order.begin());
    }

    // End iterator
    iterator end() {
        return iterator(order.end());
    }

private:
    std::list<std::pair<KeyType, ValueType>> order; // List to maintain order
    std::unordered_map<KeyType, typename std::list<std::pair<KeyType, ValueType>>::iterator> map; // Map for fast access
};

// using nodes_t = std::map<string, shared_ptr<Node>>;
// using edges_t = std::map<string, shared_ptr<vector<shared_ptr<Edge>>>>;
// using backwards_t = std::map<string, shared_ptr<vector<shared_ptr<Backward>>>>;
using nodes_t = dict<string, shared_ptr<Node>>;
using edges_t = dict<string, shared_ptr<vector<shared_ptr<Edge>>>>;
using backwards_t = dict<string, shared_ptr<vector<shared_ptr<Backward>>>>;

static void dfs1(const string &n, nodes_t &nodes, edges_t &edges,
                 vector<string> &seq, unordered_map<string, bool> &vis) {
    nodes[n]->scc = -1;
    vis[n] = true;

    for (auto &e: *edges[n]) {
        if (e->next == "")
            continue;
        if (!vis[e->next]) {
            dfs1(e->next, nodes, edges, seq, vis);
        }
    }

    seq.push_back(n);
}

static void dfs2(const string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards,
                 vector<string> &seq, unordered_map<string, bool> &vis, int sccCnt) {
    nodes[n]->scc = sccCnt;

    for (auto &e: *backwards[n]) {
        if (nodes[e->from]->scc == -1) {
            dfs2(e->from, nodes, edges, backwards, seq, vis, sccCnt);
        }
    }
}

static void update_scc(nodes_t &nodes, edges_t &edges, backwards_t &backwards, vector<string> &seq) {
    int sccCnt = 0;
    unordered_map<string, bool> vis;

    for (auto &node: nodes) {
        auto n = node.first;

        if (!vis[n])
            dfs1(n, nodes, edges, seq, vis);
    }

    for (auto it = seq.rbegin(); it != seq.rend(); ++it) {
        auto n = *it;

        if (nodes[n]->scc == -1) {
            sccCnt++;
            dfs2(n, nodes, edges, backwards, seq, vis, sccCnt);
        }
    }
}

#ifdef DEBUG
#define RULE_RETURN_TRUE(n) return std::make_pair(__func__, n)
#define RULE_RETURN_FALSE(n) return std::make_pair(__func__, string(""))
using rule_ret_t = std::pair<string, string>;
#define RULE_RESULT_NOT_NONE(r) (r.second != "")
#else
#define RULE_RETURN_TRUE(n) return true
#define RULE_RETURN_FALSE(n) return false
#define RULE_RESULT_NOT_NONE(r) r
using rule_ret_t = bool;
#endif

static rule_ret_t rule_eliminate_leaf(const string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    if (edges[n]->size() == 0 && backwards[n]->size() == 1 && nodes[n]->loop_use.size() == 0) {
        //auto P = backwards[n]->at(0)->from;
        auto e = backwards[n]->at(0)->edge;

        e->insts.insert(e->insts.end(), nodes[n]->insts.begin(), nodes[n]->insts.end());
        e->next = "";

        nodes.erase(n);
        edges.erase(n);
        backwards.erase(n);

        RULE_RETURN_TRUE(n);
    }

    RULE_RETURN_FALSE(n);
}

static rule_ret_t rule_eliminate_bridge(const string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    if (edges[n]->size() == 1 && backwards[n]->size() == 1 && nodes[n]->loop_use.size() == 0) {
        auto P = backwards[n]->at(0)->from;
        auto e1 = backwards[n]->at(0)->edge;
        auto S = edges[n]->at(0)->next;
        auto e2 = edges[n]->at(0);

        e1->next = S;
        e1->insts.insert(e1->insts.end(), nodes[n]->insts.begin(), nodes[n]->insts.end());
        e1->insts.insert(e1->insts.end(), e2->insts.begin(), e2->insts.end());
        e1->backward = e2->backward;

        if (e2->backward) {
            e2->backward->from = P;
            e2->backward->edge = e1;
        }

        nodes.erase(n);
        edges.erase(n);
        backwards.erase(n);
        RULE_RETURN_TRUE(n);
    }

    RULE_RETURN_FALSE(n);
}

static rule_ret_t rule_merge_branches(const string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    if (edges[n]->size() == 0)
        RULE_RETURN_FALSE(n);

    string S = "";

    for (auto &e: *edges[n]) {
        if (e->next != "") {
            if (S == "") {
                S = e->next;
            } else if (S != e->next) {
                RULE_RETURN_FALSE(n);
            }
        }
    }

    if (S != "" && edges[n]->size() <= 1)
        RULE_RETURN_FALSE(n);

    if (edges[n]->at(0)->cond == nullptr) {
        auto t = edges[n]->at(0);

        edges[n]->at(0) = edges[n]->back();
        edges[n]->back() = t;
    }

    auto inst = &edges[n]->back()->insts;
    unique_ptr<vector<shared_ptr<IRInst>>> old_inst = nullptr;

    for (auto it = std::next(edges[n]->rbegin()); it != edges[n]->rend(); ++it) {
        auto e = *it;

        assert(e->cond != nullptr);
        auto true_body = make_unique<vector<unique_ptr<IRInst>>>();
        auto false_body = make_unique<vector<unique_ptr<IRInst>>>();

        for (auto &i: e->insts) {
            true_body->push_back(unique_ptr<IRInst>(i->clone()));
        }

        for (auto &i: *inst) {
            false_body->push_back(unique_ptr<IRInst>(i->clone()));
        }


        inst = new vector<shared_ptr<IRInst>>();
        old_inst.reset(inst);
        inst->push_back(make_shared<IIf>(unique_ptr<IRValue>(e->cond->clone()), std::move(true_body),
                                                             std::move(false_body)));
    }
    nodes[n]->insts.insert(nodes[n]->insts.end(), inst->begin(), inst->end());

    if (S == "")
        edges[n]->clear();
    else {
        edges[n]->clear();
        edges[n]->push_back(make_shared<Edge>(S, nullptr, vector<shared_ptr<IRInst>>()));
        backwards[S]->erase(std::remove_if(backwards[S]->begin(), backwards[S]->end(),
                                           [&](const auto &e) { return e->from == n; }),
                            backwards[S]->end());
        backwards[S]->push_back(make_shared<Backward>(n, edges[n]->at(0)));
        edges[n]->at(0)->backward = backwards[S]->back();
    }

    RULE_RETURN_TRUE(n);
}

static rule_ret_t rule_merge_branches_local(string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    if (edges[n]->size() == 0)
        RULE_RETURN_FALSE(n);

    for (int i = 0; i < edges[n]->size(); i++) {
        auto &e = edges[n]->at(i);

        for (int j = 0; j < edges[n]->size(); j++) {
            auto &ee = edges[n]->at(j);

            if (e == ee) {
                continue;
            }

            if (e->next != "" && ee->next != "" && e->next == ee->next) {
                if (e->cond != nullptr && ee->cond != nullptr) {
                    auto e_cond = unique_ptr<IRValue>(e->cond->clone());
                    auto ee_cond = unique_ptr<IRValue>(ee->cond->clone());
                    auto cond_list = make_unique<vector<unique_ptr<IRValue>>>();

                    cond_list->push_back(std::move(e_cond));
                    cond_list->push_back(std::move(ee_cond));

                    e->cond = make_shared<VExpr>(TBool::TBOOL, Op::OOr, std::move(cond_list));
                } else if (ee->cond != nullptr) {
                    e->cond = ee->cond;
                }

                //make_shared<IIf>(unique_ptr<IRValue>(e->cond->clone()), std::move(ee->insts), std::move(e->insts));
                auto true_body = make_unique<vector<unique_ptr<IRInst>>>();
                auto false_body = make_unique<vector<unique_ptr<IRInst>>>();

                for (auto &i: ee->insts) {
                    true_body->push_back(unique_ptr<IRInst>(i->clone()));
                }

                for (auto &i: e->insts) {
                    false_body->push_back(unique_ptr<IRInst>(i->clone()));
                }

                e->insts.clear();
                e->insts.push_back(make_shared<IIf>(unique_ptr<IRValue>(e->cond->clone()), std::move(true_body),
                                                    std::move(false_body)));

                edges[n]->erase(std::remove_if(edges[n]->begin(), edges[n]->end(),
                                               [&](const auto &x) { return x == ee; }),
                                edges[n]->end());
                backwards[e->next]->erase(std::remove_if(backwards[e->next]->begin(), backwards[e->next]->end(),
                                                          [&](const auto &be) { return be == ee->backward; }),
                                           backwards[e->next]->end());

                RULE_RETURN_TRUE(n + " " + std::to_string(i) + ", " + std::to_string(j));
            }
        }
    }

    RULE_RETURN_FALSE(n);
}

static rule_ret_t rule_duplicate_node(string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    string S = "";

    if (edges[n]->size() > 1 || backwards[n]->size() <= 1 || nodes[n]->loop_use.size() != 0)
        RULE_RETURN_FALSE(n);

    if (edges[n]->size() == 1) {
        S = edges[n]->at(0)->next;
        if (S == n)
            RULE_RETURN_FALSE(n);
    }

    if (S != "") {
        backwards[S]->erase(std::remove_if(backwards[S]->begin(), backwards[S]->end(),
                                           [&](const auto &be) { return be->from == n; }),
                            backwards[S]->end());
    }

    for (auto &be: *backwards[n]) {
        be->edge->insts.insert(be->edge->insts.end(), nodes[n]->insts.begin(), nodes[n]->insts.end());

        if (edges[n]->size() == 1)
            be->edge->insts.insert(be->edge->insts.end(), edges[n]->at(0)->insts.begin(), edges[n]->at(0)->insts.end());
        be->edge->next = S;
        if (S == "")
            be->edge->backward = nullptr;
        else {
            backwards[S]->push_back(make_shared<Backward>(be->from, be->edge));
            be->edge->backward = backwards[S]->back();
        }
    }

    nodes.erase(n);
    edges.erase(n);
    backwards.erase(n);

    RULE_RETURN_TRUE(n);
}

template<template<typename...>class PtrType>
static void collect_continue_break(const std::vector<PtrType<IRInst>>& insts,
                                   const std::function<void(IRInst *)>& callback) {
    for (auto &i : insts) {
        if (dynamic_cast<IContinue *>(i.get()) || dynamic_cast<IBreak *>(i.get())) {
            callback(i.get());
        }
        else if (auto ifInst = dynamic_cast<IIf *>(i.get())) {
            collect_continue_break(*ifInst->true_body.get(), callback);
            collect_continue_break(*ifInst->false_body.get(), callback);
        }
    }
}

static rule_ret_t rule_destruct_scc(int scc, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    string P, S;
    vector<string> scc_nodes;

    for (auto &node: nodes) {
        auto n = node.first;
        auto n_scc = node.second->scc;

        if (n_scc == scc) {
            bool ret;
            auto collect_cb = [&](IRInst *inst) {
                auto cont_break_inst = dynamic_cast<IContBreak *>(inst);

                if (cont_break_inst) {
                    if (*cont_break_inst->Loop != "" && nodes[*cont_break_inst->Loop]->scc != scc) {
                        ret = false;
                        return;
                    }
                } else {
                    throw std::runtime_error("Unknown loop instruction: " + inst->to_coq());
                }

                ret = true;
                return;
            };

            scc_nodes.push_back(n);

            for (auto &be: *backwards[n]) {
                if (nodes[be->from]->scc != scc) {
                    if (P != "")
                        RULE_RETURN_FALSE(n);
                    P = n;
                }
            }

            collect_continue_break(nodes[n]->insts, collect_cb);
            if (!ret)
                RULE_RETURN_FALSE(n);


            for (auto &e: *edges[n]) {
                collect_continue_break(e->insts, collect_cb);
                if (!ret)
                    RULE_RETURN_FALSE(n);

                if (e->next == "" || nodes[e->next]->scc == scc)
                    continue;

                if (S != "" && S != e->next)
                    RULE_RETURN_FALSE(n);

                S = e->next;
            }
        }
    }

    if (scc_nodes.size() == 1) {
        string n = scc_nodes[0];
        bool self_loop = false;

        for (auto &e: *edges[n]) {
            if (e->next == n) {
                self_loop = true;
                break;
            }
        }

        if (!self_loop)
            RULE_RETURN_FALSE(n);
    }

    assert(P != "");
    nodes[P]->loop_use.insert(P);

    // break edges
    for (auto &n: scc_nodes) {
        for (auto &e: *edges[n]) {
            if (e->next == P) {
                backwards[P]->erase(std::remove_if(backwards[P]->begin(), backwards[P]->end(),
                                                   [&](const auto &be) { return be == e->backward; }),
                                    backwards[P]->end());
                auto cont_inst = make_shared<IContinue>();

                e->backward = nullptr;
                e->next = "";
                e->insts.push_back(cont_inst);
                //cont_inst->Loop = P;
                cont_inst->update_Loop(P);
            } else if (S != "" && e->next == S) {
                auto brk_inst = make_shared<IBreak>();

                nodes[S]->loop_use.insert(P);
                backwards[S]->erase(std::remove_if(backwards[S]->begin(), backwards[S]->end(),
                                                   [&](const auto &be) { return be == e->backward; }),
                                    backwards[S]->end());
                e->backward = nullptr;
                e->next = "";
                e->insts.push_back(brk_inst);
                //brk_inst->Loop = P;
                //brk_inst->After = S;
                brk_inst->update_Loop(P);
                brk_inst->update_After(S);
            }
        }
    }

    RULE_RETURN_TRUE(P + S);
}

static rule_ret_t rule_destruct_inner_scc(int scc, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    string P, S, outer_loop, outer_after;
    vector<string> scc_nodes;
    bool is_inner = false;

    for (auto &node: nodes) {
        auto n = node.first;
        auto collect_cb = [&](IRInst *inst) {
                auto cont_break_inst = dynamic_cast<IContBreak *>(inst);

                if (cont_break_inst) {
                    if (*cont_break_inst->Loop != "" && nodes[*cont_break_inst->Loop]->scc != scc) {
                        is_inner = true;

                        if (outer_loop != "")
                            assert(outer_loop == *cont_break_inst->Loop);
                        outer_loop = *cont_break_inst->Loop;

                        if (dynamic_cast<IBreak *>(cont_break_inst)) {
                            if (outer_after != "")
                                assert(outer_after == *cont_break_inst->After);
                            outer_after = *cont_break_inst->After;
                        }
                    }
                } else {
                    throw std::runtime_error("Unknown loop instruction: " + inst->to_coq());
                }
            };

        if (node.second->scc != scc)
            continue;

        scc_nodes.push_back(n);

        for (auto &be: *backwards[n]) {
            if (nodes[be->from]->scc != scc) {
                if (P != "")
                    RULE_RETURN_FALSE(n);
                P = n;
            }
        }

        collect_continue_break(nodes[n]->insts, collect_cb);

        for (auto &e: *edges[n]) {
            collect_continue_break(e->insts, collect_cb);

            if (e->next == "" || nodes[e->next]->scc == scc)
                continue;

            if (S != "" && S != e->next)
                RULE_RETURN_FALSE(n);

            S = e->next;
        }
    }

    if (!is_inner)
        RULE_RETURN_FALSE(P + S);

    if (scc_nodes.size() == 1) {
        string n = scc_nodes[0];
        bool self_loop = false;

        for (auto &e: *edges[n]) {
            if (e->next == n) {
                self_loop = true;
                break;
            }
        }

        if (!self_loop)
            RULE_RETURN_FALSE(n);
    }

    assert(P != "");
    nodes[P]->loop_use.insert(P);

    auto pre_blk = P + "..prep";
    auto succ_blk = P + "..succ";
    auto pre_node = make_shared<Node>();

    pre_node->insts.push_back(make_shared<IAssign>(TBool::TBOOL, P + "_cont", make_unique<VBool>(false)));
    pre_node->insts.push_back(make_shared<IAssign>(TBool::TBOOL, P + "_brk", make_unique<VBool>(false)));

    nodes[pre_blk] = pre_node;

    auto pre_edge = make_shared<Edge>(P, nullptr, vector<shared_ptr<IRInst>>());

    edges[pre_blk] = make_shared<vector<shared_ptr<Edge>>>();
    edges[pre_blk]->push_back(pre_edge);
    backwards[pre_blk] = make_shared<vector<shared_ptr<Backward>>>();
    for (const auto &be: *backwards[P]) {
        if (nodes[be->from]->scc != scc) {
            backwards[pre_blk]->push_back(be);
        }
    }
    for (auto &be: *backwards[pre_blk]) {
        be->edge->next = pre_blk;
    }
    backwards[P]->clear();
    backwards[P]->push_back(make_shared<Backward>(pre_blk, edges[pre_blk]->at(0)));
    edges[pre_blk]->back()->backward = backwards[P]->back();

    std::function<void(vector<shared_ptr<IRInst>>&)> modify_continue_break_shared;
    std::function<unique_ptr<vector<unique_ptr<IRInst>>>(vector<unique_ptr<IRInst>>&)> modify_continue_break_unique;

    modify_continue_break_shared =
        [&](vector<shared_ptr<IRInst>> &insts) {
        auto new_insts = make_unique<vector<shared_ptr<IRInst>>>();

        for (auto &i: insts) {
            if (auto cont_break_inst = dynamic_cast<IContBreak *>(i.get())) {
                if (*cont_break_inst->Loop != "" && nodes[*cont_break_inst->Loop]->scc != scc) {
                    bool is_break = dynamic_cast<IBreak *>(cont_break_inst) != nullptr;
                    string assign = P + (is_break ? "_brk" : "_cont");
                    auto break_inst = make_shared<IBreak>();

                    new_insts->push_back(make_shared<IAssign>(TBool::TBOOL, assign, make_unique<VBool>(true)));
                    new_insts->push_back(break_inst);
                    //break_inst->Loop = P;
                    //break_inst->After = succ_blk;
                    break_inst->update_Loop(P);
                    break_inst->update_After(succ_blk);
                }
            } else if (auto if_inst = dynamic_cast<IIf *>(i.get())) {
                new_insts->push_back(make_shared<IIf>(unique_ptr<IRValue>(if_inst->cond->clone()),
                                                      modify_continue_break_unique(*if_inst->true_body),
                                                      modify_continue_break_unique(*if_inst->false_body)));
            } else {
                new_insts->push_back(i);
            }
        }

        insts.clear();
        insts.insert(insts.end(), new_insts->begin(), new_insts->end());
    };

    modify_continue_break_unique =
        [&](vector<unique_ptr<IRInst>> &insts) -> unique_ptr<vector<unique_ptr<IRInst>>> {
        auto new_insts = make_unique<vector<unique_ptr<IRInst>>>();

        for (auto &i: insts) {
            if (auto cont_break_inst = dynamic_cast<IContBreak *>(i.get())) {
                if (*cont_break_inst->Loop != "" && nodes[*cont_break_inst->Loop]->scc != scc) {
                    bool is_break = dynamic_cast<IBreak *>(cont_break_inst) != nullptr;
                    string assign = P + (is_break ? "_brk" : "_cont");
                    auto break_inst = make_unique<IBreak>();

                    new_insts->push_back(make_unique<IAssign>(TBool::TBOOL, assign, make_unique<VBool>(true)));
                    //break_inst->Loop = P;
                    //break_inst->After = succ_blk;
                    break_inst->update_Loop(P);
                    break_inst->update_After(succ_blk);
                    new_insts->push_back(std::move(break_inst));
                }
            } else if (auto if_inst = dynamic_cast<IIf *>(i.get())) {
                new_insts->push_back(make_unique<IIf>(unique_ptr<IRValue>(if_inst->cond->clone()),
                                                      modify_continue_break_unique(*if_inst->true_body),
                                                      modify_continue_break_unique(*if_inst->false_body)));
            } else {
                new_insts->push_back(std::move(i));
            }
        }
        return new_insts;
    };

    // break edges
    for (auto &n: scc_nodes) {
        modify_continue_break_shared(nodes[n]->insts);
        for (auto &e: *edges[n]) {
            modify_continue_break_shared(e->insts);
            if (e->next == P) {
                auto cont_inst = make_shared<IContinue>();

                backwards[e->next]->erase(std::remove_if(backwards[e->next]->begin(), backwards[e->next]->end(),
                                                        [&](const auto &be) { return be == e->backward; }),
                                         backwards[e->next]->end());
                e->backward = nullptr;
                e->next = "";
                e->insts.push_back(cont_inst);
                //cont_inst->Loop = P;
                cont_inst->update_Loop(P);
            } else if (S != "" && e->next == S) {
                auto brk_inst = make_shared<IBreak>();

                backwards[e->next]->erase(std::remove_if(backwards[e->next]->begin(), backwards[e->next]->end(),
                                                        [&](const auto &be) { return be == e->backward; }),
                                         backwards[e->next]->end());
                e->backward = nullptr;
                e->next = "";
                e->insts.push_back(brk_inst);
                //brk_inst->Loop = P;
                //brk_inst->After = succ_blk;
                brk_inst->update_Loop(P);
                brk_inst->update_After(succ_blk);
            }
        }
    }

    auto cont = make_unique<IContinue>();
    auto brk = make_unique<IBreak>();
    auto cont_list = make_unique<vector<unique_ptr<IRInst>>>();
    auto brk_list = make_unique<vector<unique_ptr<IRInst>>>();

    //cont->Loop = outer_loop;
    //brk->Loop = outer_loop;
    //brk->After = outer_after;
    cont->update_Loop(outer_loop);
    brk->update_Loop(outer_loop);
    brk->update_After(outer_after);

    cont_list->push_back(std::move(cont));
    brk_list->push_back(std::move(brk));

    auto inner_if = make_unique<IIf>(make_unique<VLocal>(TBool::TBOOL, P + "_brk"), std::move(brk_list), make_unique<vector<unique_ptr<IRInst>>>());
    auto outter_if = make_shared<IIf>(make_unique<VLocal>(TBool::TBOOL, P + "_cont"), std::move(cont_list), std::move(inner_if));

    auto new_node = make_shared<Node>();

    new_node->insts.push_back(outter_if);
    new_node->loop_use.insert(P);
    nodes[succ_blk] = new_node;

    if (S != "") {
        auto new_edge = make_shared<Edge>(S, nullptr, vector<shared_ptr<IRInst>>());
        auto new_edges = make_shared<vector<shared_ptr<Edge>>>();

        new_edges->push_back(new_edge);
        edges[succ_blk] = new_edges;

        backwards[succ_blk] = make_shared<vector<shared_ptr<Backward>>>();

        auto new_backward = make_shared<Backward>(succ_blk, edges[succ_blk]->back());
        backwards[S]->push_back(new_backward);
        edges[succ_blk]->back()->backward = new_backward;
    } else {
        edges[succ_blk] = make_shared<vector<shared_ptr<Edge>>>();
        backwards[succ_blk] = make_shared<vector<shared_ptr<Backward>>>();
    }

    RULE_RETURN_TRUE(P + S);
}

// This function seems never to be called
static rule_ret_t rule_duplicate_scc(int scc, nodes_t nodes, edges_t edges, backwards_t backwards) {
#if 0
    auto P_set = std::set<string>();
    string S = "";
    vector<string> scc_nodes;

    for (auto &p: nodes) {
        auto n = p.first;
        auto &node = p.second;

        if (node->loop_use.size() != 0)
            RULE_RETURN_FALSE(n);

        if (node->scc == scc) {
            scc_nodes.push_back(n);
            for (auto &be: *backwards[n]) {
                if (nodes[be->from]->scc != scc) {
                    P_set.insert(n);
                }
            }
            for (auto &e: *edges[n]) {
                if (e->next == "" || nodes[e->next]->scc == scc)
                    continue;
                if (S != "" && S != e->next)
                    RULE_RETURN_FALSE(n);
                S = e->next;
            }
        }
    }

    if (P_set.size() <= 0)
        RULE_RETURN_FALSE(n);

    auto P = vector<string>(P_set.begin(), P_set.end());
#else
    throw std::runtime_error("rule_duplicate_scc is not implemented");
#endif
}

enum complete_state { True, False, None };
template<template<typename...>class PtrType>
static void collect_break_continue(const vector<PtrType<IRInst>> &insts, vector<IRInst *> &cont_brk,
                                   string &break_point, complete_state &complete_loop, string &n) {
    for (auto &i : insts) {
        if (auto if_inst = dynamic_cast<IIf *>(i.get())) {
            collect_break_continue(*if_inst->true_body.get(), cont_brk, break_point, complete_loop, n);
            collect_break_continue(*if_inst->false_body.get(), cont_brk, break_point, complete_loop, n);
        } else if (auto break_inst = dynamic_cast<IBreak *>(i.get())) {
            cont_brk.push_back(i.get());
            if (*break_inst->Loop == n) {
                if (complete_loop == None)
                    complete_loop = True;
            } else {
                complete_loop = False;
            }

            if (break_point == "") {
                break_point = *break_inst->After;
            } else if (break_point != *break_inst->After) {
                complete_loop = False;
            }
        } else if (auto cont_inst = dynamic_cast<IContinue *>(i.get())) {
            cont_brk.push_back(i.get());
            if (*cont_inst->Loop == n) {
                if (complete_loop == None)
                    complete_loop = True;
            } else {
                complete_loop = False;
            }
        }
    }
}

static rule_ret_t rule_construct_loop(string &n, nodes_t &nodes, edges_t &edges, backwards_t &backwards) {
    string break_point = "";
    complete_state complete_loop = None;
    auto cont_brk = vector<IRInst *>();
    int lineno;

    if (edges[n]->size() == 0) {
        collect_break_continue(nodes[n]->insts, cont_brk, break_point, complete_loop, n);

        if (complete_loop == None || complete_loop == False)
            RULE_RETURN_FALSE(n);
    } else {
        RULE_RETURN_FALSE(n);
    }

    lineno = nodes[backwards[n]->back()->from]->last_inst->lineno;

    auto loop_body = make_unique<vector<unique_ptr<IRInst>>>();

    for (auto &i: nodes[n]->insts) {
        auto new_i = i->clone();

        if (auto cont_break_inst = dynamic_cast<IContBreak *>(i.get())) {
            if (std::find(cont_brk.begin(), cont_brk.end(), i.get()) != cont_brk.end()) {
                auto new_cont_break_inst = dynamic_cast<IContBreak *>(new_i);
                new_cont_break_inst->update_Loop("");
                new_cont_break_inst->update_After("");
                cont_break_inst->update_Loop("");
                cont_break_inst->update_After("");
            }
        }

        loop_body->push_back(unique_ptr<IRInst>(new_i));
    }

    nodes[n]->insts.clear();
    nodes[n]->insts.push_back(make_shared<ILoop>(std::move(loop_body), lineno));
    nodes[n]->loop_use.erase(n);

    if (break_point != "") {
        edges[n]->push_back(make_shared<Edge>(break_point, nullptr, vector<shared_ptr<IRInst>>()));
        backwards[break_point]->push_back(make_shared<Backward>(n, edges[n]->back()));
        edges[n]->back()->backward = backwards[break_point]->back();
        nodes[break_point]->loop_use.erase(n);
    }

    // for (auto i : cont_brk) {
    //     std::cout << "i: " << i << std::endl;
    //     if (auto cont_break_inst = dynamic_cast<IContBreak *>(i)) {
    //         //cont_break_inst->Loop = "";
    //         //cont_break_inst->After = "";
    //         cont_break_inst->update_Loop("");
    //         cont_break_inst->update_After("");
    //     }
    // }

    RULE_RETURN_TRUE(n);
}

unique_ptr<vector<unique_ptr<IRInst>>> control_flow_conversion(ir_blocks_t *ir_blocks) {
    nodes_t nodes;
    edges_t edges;
    backwards_t backwards;

    for (auto &block: ir_blocks->second) {
        auto node = block;

        nodes[node] = make_shared<Node>();
        edges[node] = make_shared<vector<shared_ptr<Edge>>>();
        backwards[node] = make_shared<vector<shared_ptr<Backward>>>();
    }

    // Calculate out edges
    for (auto &block: ir_blocks->second) {
        string node = block;
        auto insts = ir_blocks->first.at(block).get();
        //auto insts = block.second.get();
        IRInst *term;

        // nodes[node] = make_shared<Node>();
        // edges[node] = make_shared<vector<shared_ptr<Edge>>>();
        // backwards[node] = make_shared<vector<shared_ptr<Backward>>>();
        if (dynamic_cast<IReturn *>(insts->back().get())) {
            for (auto &inst: *insts) {
                nodes[node]->insts.push_back(shared_ptr<IRInst>(inst->clone()));
            }
        } else {
            for (auto it = insts->begin(); it != insts->end() - 1; ++it) {
                nodes[node]->insts.push_back(shared_ptr<IRInst>((*it)->clone()));
            }
        }

        nodes[node]->scc = -1;
        nodes[node]->last_inst = shared_ptr<IRInst>(insts->back()->clone());
        term = insts->back().get();

        if (dynamic_cast<IBranch *>(term)) {
            auto branch = dynamic_cast<IBranch *>(term);

            edges[node]->push_back(make_shared<Edge>(branch->succ->name, nullptr, vector<shared_ptr<IRInst>>()));
        } else if (dynamic_cast<ICondBranch *>(term)) {
            auto cond_branch = dynamic_cast<ICondBranch *>(term);

            edges[node]->push_back(make_shared<Edge>(cond_branch->true_succ->name, shared_ptr<IRValue>(cond_branch->cond->clone()), vector<shared_ptr<IRInst>>()));
            edges[node]->push_back(make_shared<Edge>(cond_branch->false_succ->name, shared_ptr<IRValue>(cond_branch->cond->clone()), vector<shared_ptr<IRInst>>()));
        } else if (dynamic_cast<ISwitch *>(term)) {
            auto switch_inst = dynamic_cast<ISwitch *>(term);

            edges[node]->push_back(make_shared<Edge>(switch_inst->def->name, nullptr, vector<shared_ptr<IRInst>>()));

            for (int i = 0; i < switch_inst->succ_list->size(); i++) {
                unique_ptr<IRValue> cond_op0(switch_inst->cond->clone());
                unique_ptr<IRValue> cond_op1(switch_inst->val_list->at(i)->clone());
                auto cond_ops = make_unique<vector<unique_ptr<IRValue>>>();
                shared_ptr<VExpr> cond;

                cond_ops->push_back(std::move(cond_op0));
                cond_ops->push_back(std::move(cond_op1));

                cond = make_shared<VExpr>(TBool::TBOOL, Op::Ceq, std::move(cond_ops));

                edges[node]->push_back(make_shared<Edge>(switch_inst->succ_list->at(i)->name, cond, vector<shared_ptr<IRInst>>()));
            }
        } else if (dynamic_cast<IReturn *>(term) == nullptr && dynamic_cast<IUnreachable *>(term) == nullptr) {
            throw std::runtime_error("Unknown terminator: " + term->to_coq());
        }

        for (auto &edge: *edges[node]) {
            auto be = make_shared<Backward>(node, edge);

            backwards[edge->next]->push_back(be);
            edge->backward = be;
        }
    }

    // Elinimate PHI nodes
    for (auto &block: nodes) {
        auto node = block.second;
        auto blk = block.first;

        for (auto &inst: node->insts) {
            if (dynamic_cast<IPHI *>(inst.get())) {
                auto phi_inst = dynamic_cast<IPHI *>(inst.get());
                auto typ = phi_inst->get_type();
                auto assg = phi_inst->assign;

                for (int i = 0; i < phi_inst->values->size(); i++) {
                    auto src = phi_inst->blocks->at(i).get();
                    auto val = phi_inst->values->at(i).get();

                    for (auto &e: *edges[src->name]) {
                        if (e->next == blk) {
                            e->insts.push_back(make_shared<IAssign>(typ, assg, unique_ptr<IRValue>(val->clone())));
                        }
                    }
                }
            }
        }

        auto &insts = nodes[blk]->insts;
        insts.erase(std::remove_if(insts.begin(), insts.end(),
                                   [](const auto &inst) { return dynamic_cast<IPHI *>(inst.get()) != nullptr; }),
                    insts.end());
    }

    // main loop
    while (nodes.size() > 1 || (!edges.empty() && edges.begin()->second->size() > 0)) {
        vector<string> seq;
        bool succ = false;
        std::function<void(string)> dbg_nodes_edges = [&](string rule) {
#ifdef DEBUG
        //std::cout << "========== " + rule + " Nodes begin ==========" << std::endl;
        // for (auto &node: nodes) {
        //     auto n = node.first;
        //     auto &insts = node.second->insts;

        //     //std::cout << "node: " << n << std::endl;
        //     for (auto &inst: insts) {
        //         std::cout << inst->to_coq() << std::endl;
        //     }
        // }
        // std::cout << "========== " + rule + " Nodes end ==========" << std::endl;

        // std::cout << "========== " + rule + " Edges begin ==========" << std::endl;
        // for (auto &edge: edges) {
        //     auto n = edge.first;
        //     auto es = edge.second;

        //     for (auto &e: *es) {
        //         //std::cout << "edge: " << n << " -> " << e->next << std::endl;
        //         for (auto &inst: e->insts) {
        //             std::cout << inst->to_coq() << std::endl;
        //         }
        //     }
        // }
        // std::cout << "========== " + rule + " Edges end ==========" << std::endl;
        // std::cout << "============" + rule + " backwards begin ==========" << std::endl;

        // std::cout << "nodes: " << nodes.size() << std::endl;
        // std::cout << "edges:" << std::endl;
        // for (auto &be: edges) {
        //     std::cout << be.first << ": " << be.second->size() << std::endl;
        // }
        // std::cout << "backwards:" << std::endl;
        // for (auto &be: backwards) {
        //     std::cout << be.first << ": " << be.second->size() << std::endl;
        // }
#endif
        };
        vector<std::function<rule_ret_t(string &)>> rules = {
            [&](string &n) { dbg_nodes_edges("eliminate_leaf"); return rule_eliminate_leaf(n, nodes, edges, backwards); },
            [&](string &n) { dbg_nodes_edges("eliminate_bridge"); return rule_eliminate_bridge(n, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("merge_branches");
                return rule_merge_branches(n, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("destruct_scc");
                return rule_destruct_scc(nodes[n]->scc, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("destruct_inner_scc");
                return rule_destruct_inner_scc(nodes[n]->scc, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("construct_loop");
                return rule_construct_loop(n, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("merge_branches_local");
                return rule_merge_branches_local(n, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("duplicate_node");
                return rule_duplicate_node(n, nodes, edges, backwards); },
            [&](string &n) {
                dbg_nodes_edges("duplicate_scc");
                return rule_duplicate_scc(nodes[n]->scc, nodes, edges, backwards); },
        };

        update_scc(nodes, edges, backwards, seq);

        for (auto &rule: rules) {
            succ = false;
            for (auto &n : seq) {
                auto r_out = rule(n);

                if (RULE_RESULT_NOT_NONE(r_out)) {
#ifdef DEBUG
                    //std::cout << r_out.first << " " << r_out.second << std::endl;
#endif
                    succ = true;
                    break;
                }
            }
            if (succ)
                break;
        }

        if (!succ) {
            LOG_ERROR << "Failed to convert control flow graph" << std::endl;
            return nullptr;
        }
    }

    auto body = make_unique<vector<unique_ptr<IRInst>>>();

    for (auto &inst: nodes.begin()->second->insts) {
        body->push_back(unique_ptr<IRInst>(inst->clone()));
    }

    return body;
}
}; // namespace autov::IRLoader