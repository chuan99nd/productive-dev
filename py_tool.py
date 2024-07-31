def sync_config_file(src_path, dst_path):
    with open(src_path, 'r') as src_file:
        src_content = src_file.read()
    with open(dst_path, 'w') as dst_file:
        dst_file.write(src_content)
