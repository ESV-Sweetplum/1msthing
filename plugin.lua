function draw()
    imgui.Begin("1 ms thing")

    state.IsWindowHovered = imgui.IsWindowHovered()

    if imgui.Button("up") then
        local notes = state.SelectedHitObjects
        local result = {}

        for _, note in pairs(notes) do
            table.insert(result,
                utils.CreateHitObject(note.StartTime + 1, note.Lane, note.EndTime == 0 and 0 or note.EndTime + 1,
                    note.HitSound, note.EditorLayer, note.Type))
        end

        actions.PerformBatch({
            utils.CreateEditorAction(action_type.RemoveHitObjectBatch, notes),
            utils.CreateEditorAction(action_type.PlaceHitObjectBatch, result),
        })
        actions.SetHitObjectSelection(result)
    end

    if imgui.Button("down") then
        local notes = state.SelectedHitObjects
        local result = {}

        for _, note in pairs(notes) do
            table.insert(result,
                utils.CreateHitObject(note.StartTime - 1, note.Lane, note.EndTime == 0 and 0 or note.EndTime - 1,
                    note.HitSound, note.EditorLayer, note.Type))
        end

        actions.PerformBatch({
            utils.CreateEditorAction(action_type.RemoveHitObjectBatch, notes),
            utils.CreateEditorAction(action_type.PlaceHitObjectBatch, result),
        })
        actions.SetHitObjectSelection(result)
    end

    imgui.End()
end
