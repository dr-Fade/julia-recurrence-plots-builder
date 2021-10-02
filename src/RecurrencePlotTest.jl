module RecurrencePlotTest

using DynamicalSystems, DelimitedFiles, Plots

"""
The files are assumed to have a space separated floating point numbers and nothing else.
"""
load_data(filename::String, columns::Array{Int}) = (
    open(readdlm, filename)
    |> float
    |> Dataset
)[:, columns]

"""
Load files, build datasets from columns, and create recurrence matrices for each file treating columns as separate datasets.
"""
function build_recurrence_plot_diagrams_for_each_column(files::Array{String}, ε::Float64, columns::Int...)
    gr()
    for file in files
        for column in columns
            R = RecurrenceMatrix(load_data(file, [column]), ε)
            xs, ys = coordinates(R)
            Plots.scatter(xs, ys, color = :black, markersize = 1, legend = false)
            output_file_name = "$file-$column.png"
            Plots.savefig(output_file_name)
            println("saved new recurrence plot - $output_file_name")
        end
    end
end

"""
Load files, build datasets from columns, and create recurrence matrices for each file treating columns as point coordinates.
"""
function build_recurrence_plot_diagrams(files::Array{String}, ε::Float64, attractor_columns::Int...)
    gr()
    for file in files
        R = RecurrenceMatrix(load_data(file, [c for c in attractor_columns]), ε)
        xs, ys = coordinates(R)
        Plots.scatter(xs, ys, color = :black, markersize = 1, legend = false)
        output_file_name = "$file.png"
        Plots.savefig(output_file_name)
        println("saved new recurrence plot - $output_file_name")
    end
end

end # module
