import os
import sys
import requests
from git import Repo, GitCommandError
import time

def get_org_repos(org_name, token):
    repos = []
    page = 1
    while True:
        url = f'https://api.github.com/orgs/{org_name}/repos?per_page=100&page={page}'
        headers = {
            'Authorization': f'token {token}'
        }
        response = requests.get(url, headers=headers)

        if response.status_code == 403:
            rate_limit_info = response.headers.get('X-RateLimit-Remaining')
            if rate_limit_info == '0':
                print("Rate limit exceeded. Please wait before making more requests.")
                print_rate_limit_status(token)
                sys.exit(1)

        if response.status_code != 200:
            raise Exception(f"Error fetching repos: {response.status_code} {response.text}")

        data = response.json()
        print(f"Fetched {len(data)} repositories from page {page}")

        if not data:
            break

        repos.extend(data)
        page += 1

    print(f"Total repositories fetched: {len(repos)}")
    return repos

def print_rate_limit_status(token):
    url = 'https://api.github.com/rate_limit'
    headers = {
        'Authorization': f'token {token}'
    }
    response = requests.get(url, headers=headers)
    rate_limit = response.json()
    print(f"Rate limit status: {rate_limit}")

def clone_repo(repo_url, clone_path, retries=3):
    for attempt in range(retries):
        try:
            print(f"Cloning {repo_url} into {clone_path} (Attempt {attempt + 1}/{retries})...")
            Repo.clone_from(repo_url, clone_path)
            print(f"Successfully cloned {repo_url}")
            return
        except GitCommandError as e:
            print(f"Error cloning {repo_url}: {e}")
            if attempt < retries - 1:
                print("Retrying...")
                time.sleep(5)  # Wait for 5 seconds before retrying
            else:
                print("Max retries reached. Skipping this repository.")
                raise

def clone_repos(repos, clone_dir):
    if not os.path.exists(clone_dir):
        os.makedirs(clone_dir)

    for repo in repos:
        repo_name = repo['name']
        repo_url = repo['clone_url']
        clone_path = os.path.join(clone_dir, repo_name)

        if not os.path.exists(clone_path):
            try:
                clone_repo(repo_url, clone_path)
            except Exception as e:
                print(f"Failed to clone {repo_name}: {e}")
        else:
            print(f"{repo_name} already exists, skipping.")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python clone_org_repos.py <ORG_NAME> <CLONE_DIR>")
        sys.exit(1)

    GITHUB_PERSONAL_TOKEN = os.getenv('GITHUB_PERSONAL_TOKEN')
    if not GITHUB_PERSONAL_TOKEN:
        print("Error: GITHUB_PERSONAL_TOKEN environment variable not set.")
        sys.exit(1)

    ORG_NAME = sys.argv[1]
    CLONE_DIR = sys.argv[2]

    print_rate_limit_status(GITHUB_PERSONAL_TOKEN)

    repos = get_org_repos(ORG_NAME, GITHUB_PERSONAL_TOKEN)
    clone_repos(repos, CLONE_DIR)
    print("All repositories have been cloned.")
