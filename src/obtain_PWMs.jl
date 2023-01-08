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

function save_motifs(ms::motifs; save_loc=nothing, discovered_folder_name = "discovered_motifs")
    where2save = nothing
    if isnothing(save_loc)
        where2save = joinpath(pwd(), discovered_folder_name)
    else
        where2save = joinpath(save_loc, discovered_folder_name)
    end
    mkpath(where2save)
    @save joinpath(where2save, "motifs.jld2") ms
end

"""
Save the discovered motifs in the joinpath(JLD2path, "discovered_motifs") folder
    - If JLD2path is not provided, then the motifs are saved in the current directory.
"""
function obtain_PWMs_from_JLD2(;JLD2path=nothing, save_motif_as_JLD2=false)
    saved_loc = isnothing(JLD2path) ? joinpath(pwd(), "sparse_rep") : joinpath(JLD2path, "sparse_rep");
    # filter_path      = joinpath(save_loc, "filters.jld2")
    data_path        = joinpath(saved_loc, "data.jld2")
    sparse_code_path = joinpath(saved_loc, "sparse_code.jld2")
    filterlen_path   = joinpath(saved_loc, "filterlen.jld2")
    if isfile(data_path) && isfile(sparse_code_path) && isfile(filterlen_path)
        @load joinpath(saved_loc, "data.jld2") data
        @load joinpath(saved_loc, "sparse_code.jld2") Z
        @load joinpath(saved_loc, "filterlen.jld2") f
        ms = obtain_PWMs(Z, data, f);
        if save_motif_as_JLD2
            save_motifs(ms; save_loc=JLD2path)
        else
            return ms
        end        
    else
        error("The required files are not present in the directory $JLD2path.")
    end
end