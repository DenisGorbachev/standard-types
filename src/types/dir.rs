use subtype::{subtype_path_buf, IsDir};

subtype_path_buf!(
    pub struct Dir(PathBuf | IsDir);
);

impl Dir {}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io;
    use tempfile::{tempdir, NamedTempFile};

    #[test]
    fn must_validate_dir() -> io::Result<()> {
        let tempdir = tempdir()?;
        let tempfile = NamedTempFile::new()?;
        assert!(Dir::try_from(tempdir.path()).is_ok());
        assert!(Dir::try_from(tempfile.path()).is_err());
        Ok(())
    }
}
