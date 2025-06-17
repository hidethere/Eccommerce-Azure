using Product_service.Domain;

namespace Product_service.Repository
{
    public interface ICategoryRepository
    {
        public Task<Category> AddAsync(Category category);
        public Task<Category> FindCategoryByIdAsync(string categoryId);
        public Task<Category> FindCategoryByNameAsync(string name);
        public Task<IEnumerable<Category>> FindAllCategoriesAsync();
    }
}
