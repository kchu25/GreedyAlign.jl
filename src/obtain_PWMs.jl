const esd_alpha=0.05
const esd_r = 1000
const __k__ = 8
const esd_count_thresh = 10
const percentage_thresh = 0.0055
const ic_expand_t = 0.7
const ic_shrink_t = 0.4
const allr_thresh = 0.225
const diff_tol = 4
const alpha_fisher = 1e-5
const indep_run = 8
const dep_run = 4

function obtain_PWMs(Z::Array{float_type, 3}, data, flen)::motifs
    @info "Obtaining enriched triplets as PWMs."
            new_cmats = obtain_count_matrices(Z, 
                                data, flen;
                                esd_alpha=esd_alpha,
                                esd_r=esd_r, k=__k__,
                                esd_count_thresh=esd_count_thresh,
                                percentage_thresh=percentage_thresh,
                                ic_expand_t=ic_expand_t,
                                ic_shrink_t=ic_shrink_t,
                                allr_thresh=allr_thresh,
                                diff_tol=diff_tol);
        
            @info "Perform greedy alignment."
            ms = greedy_alignment(new_cmats, data;
                                        allr_thresh=allr_thresh,
                                        alpha_fisher=alpha_fisher,
                                        ic_expand_t=ic_expand_t,
                                        ic_shrink_t=ic_shrink_t,
                                        indep_run=indep_run,
                                        dep_run=dep_run,
                                        diff_tol=diff_tol,
                                        gpu=true
                                        );
            return ms
end