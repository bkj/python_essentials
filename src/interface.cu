// interface.cu

// ?? Is there a way to automatically unwrap torch::Tensor to pointers, to reduce amount of glue code?

#include <iostream>

#include <pybind11/pybind11.h>
#include <torch/extension.h>
#include "gunrock/applications/sssp.hxx"

namespace py = pybind11;
using namespace gunrock;

// --
// Builder

template <
  memory::memory_space_t space,
  graph::view_t build_views,
  typename vertex_type,
  typename edge_type,
  typename weight_type
>
auto from_csr(
    vertex_type const& n_rows,
    vertex_type const& n_cols,
    edge_type const& n_edges,
    torch::Tensor Ap_arr,
    torch::Tensor J_arr,
    torch::Tensor X_arr
) {
  return graph::build::from_csr<space, build_views>(
        n_rows,                          // rows
        n_cols,                          // columns
        n_edges,                         // nonzeros
        Ap_arr.data_ptr<edge_type>(),    // row_offsets
        J_arr.data_ptr<vertex_type>(),   // column_indices
        X_arr.data_ptr<weight_type>()    // values
    );
}

// --
// Apps

template <
  typename graph_type,
  typename vertex_t = typename graph_type::vertex_type,
  typename edge_t   = typename graph_type::edge_type,
  typename weight_t = typename graph_type::weight_type
>
void sssp_run(
  graph_type&   G,
  vertex_t      single_source,
  torch::Tensor distances,
  torch::Tensor predecessors
) {
  sssp::run(
    G,
    single_source,
    distances.data_ptr<weight_t>(),
    predecessors.data_ptr<vertex_t>()
  );
}

PYBIND11_MODULE(pygunrock, m) {

  // --
  // Typedefs

  using vertex_t    = int;
  using edge_t      = int;
  using weight_t    = float;

  constexpr graph::memory_space_t space = memory::memory_space_t::device;
  constexpr graph::view_t build_views = graph::view_t::csr;

  using graph_type = decltype(from_csr<space, build_views, vertex_t, edge_t, weight_t>(
    std::declval<vertex_t>(),
    std::declval<vertex_t>(),
    std::declval<edge_t>(),
    std::declval<torch::Tensor>(),
    std::declval<torch::Tensor>(),
    std::declval<torch::Tensor>()
  ));

  // --
  // Interface

  py::class_<graph_type>(m, "CSRGraph")
    .def("get_number_of_vertices" , &graph_type::get_number_of_vertices)
    .def("get_number_of_edges"    , &graph_type::get_number_of_edges)
    .def("is_directed"            , &graph_type::is_directed);

  m.def("from_csr", from_csr<space, build_views, vertex_t, edge_t, weight_t>);
  m.def("sssp",     sssp_run<graph_type>);
}
