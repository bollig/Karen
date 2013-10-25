~/Karen/keeneland_benchmarks/cosine_bell/alltoall



These results were run on Keeneland. The changes to MPI communication are the result of changing from blocking communication (MPI_send/MPI_recv) to non-blocking communication (MPI_alltoall).

speedup_1proc_oneWarpPerStencil.eps shows that our GPU kernel is not much different than in the paper. I have a list of optimizations I'm going through, but this test case focuses on improving the communication. 

speedup_1CPU_vs_NCPU.eps  shows the strong scalability of our method on Multiple CPUs. In distributed computing, ideal scaling is linear. This figure demonstrates that our method does scale linearly (almost super-linearly) as the number of CPUs increases, so our prospect for spanning all CPUs on Keeneland is within reach for problem sizes large enough. The super-linear speedup seen for 10 processors results from improved caching on processors as their individual problem sizes decrease and the processors are able to keep a larger percentage of the problem within fast cache memory.

speedup_1CPU_vs_NGPU_WarpPerStencil.eps  shows the scaling of multiple GPUs vs 1 CPU. Ideally, this figure would be the product of the previous two figures since the GPUs are attached to CPUs in a one to one correspondence. However, we see from the sub-linear scaling that while the GPU accelerators are decreasing the time to compute solutions, there is less and less return of investment as the number of processors increase. Between this Figure and the previous, the only thing that differs is the hardware on which stencils are evaluated. The cost of communication stays the same as in the previous figure. But that means the communication consumes a increasing percentage of the iteration time, until is dominates. 
Additionally, computing on the GPU requires transfer (additional communication) of data between CPU and GPU. 

speedup_1GPU_vs_NGPU_WarpPerStencil.eps shows the scalability of multiple GPUs vs 1 GPU. Here we see a sub-linear behavior for all cases. This is attributed to both the cost of transfer between CPUs and GPUs and the decreasing problem size as number of processors increases, which underutilizes the GPUs. 


multiCPU_costs.eps and multiGPU_warp_costs.eps show the smaller percentage of time per iteration dedicated to communication compared to the figures in the paper. In the multiGPU_warp_costs.eps, the way the times bottom out indicates we are/have converged on the minimum time required to launch a GPU kernel, transfer to/from the GPU, and communicate the problem via MPI. To scale to more processors, a larger problem size is absolutely necessary.


I am generating another set of figures that demonstrate the scaling when we overlap communication and computation. MPI collectives do not allow overlap, but the asynchronous GPU kernel launches do. Therefore, I expect:
    - the scaling on multiple CPUs vs 1 CPU to be the same as it is now
    - the scaling on multiple GPUs vs 1 GPU will improve to linear/super-linear for problem sizes that occupy the hardware longer than the minimum kernel launch time. For N=27556 we might only see linear speedup up to 6 or 8 processors. 
    - larger problem sizes will still be necessary (I have benchmarks for 100K, 500K and 1M on the sphere).

