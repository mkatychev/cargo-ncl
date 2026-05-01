let WorkspacePackage | doc "a cargo crate manifest where version and edition point to a workspace manifest" =
  std.contract.from_validator (fun package =>
    if package.version == { workspace = true } then
      'Ok
    else
      'Error {
        message = "%{package.name} is invalid",
        notes = ["version must be { workspace = true }"],
      }
  )
in
let WorkspaceLints | doc "a cargo crate manifest where lints is set to workspace = true" =
  std.contract.from_validator (fun lints =>
    if lints == { workspace = true } then
      'Ok
    else
      'Error {
        message = "[lints] is invalid",
        notes = ["must be `{ workspace = true }`"],
      }
  )
in
{
  package | WorkspacePackage,
  lints | WorkspaceLints,
  ..
}
